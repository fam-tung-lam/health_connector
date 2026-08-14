<script setup lang="ts">
import { computed, onMounted, ref } from "vue";
import dataset from "../../data/health-data-types.json";
import { usePlatform } from "../composables/usePlatform";
import CopyButton from "./CopyButton.vue";

type PlatformFilter = "all" | "android" | "ios" | "both";

const { activePlatform } = usePlatform();

const query = ref("");
const platform = ref<PlatformFilter>("all");

// Someone who has been reading the iOS tabs is almost certainly shipping iOS.
// Applied on mount so the server-rendered markup stays platform-neutral.
onMounted(() => {
  platform.value = activePlatform.value;
});
const category = ref("all");
const aggregatableOnly = ref(false);

const platformFilters: { id: PlatformFilter; label: string }[] = [
  { id: "all", label: "All platforms" },
  { id: "android", label: "Health Connect" },
  { id: "ios", label: "HealthKit" },
  { id: "both", label: "Both" },
];

const results = computed(() => {
  const needle = query.value.trim().toLowerCase();

  return dataset.dataTypes.filter((entry) => {
    if (category.value !== "all" && entry.category !== category.value) return false;
    if (aggregatableOnly.value && entry.aggregations.length === 0) return false;

    if (platform.value === "android" && !entry.android) return false;
    if (platform.value === "ios" && !entry.ios) return false;
    if (platform.value === "both" && !(entry.android && entry.ios)) return false;

    if (!needle) return true;

    return [
      entry.name,
      entry.description,
      entry.constant,
      entry.category,
      entry.group,
      entry.androidApi?.label ?? "",
      entry.iosApi?.label ?? "",
    ]
      .join(" ")
      .toLowerCase()
      .includes(needle);
  });
});

const grouped = computed(() => {
  const groups = new Map<string, typeof dataset.dataTypes>();

  for (const entry of results.value) {
    const key = entry.category === entry.group
      ? entry.category
      : `${entry.category} › ${entry.group}`;
    const bucket = groups.get(key);
    if (bucket) bucket.push(entry);
    else groups.set(key, [entry]);
  }

  return [...groups];
});

const isFiltered = computed(
  () =>
    query.value.trim() !== "" ||
    platform.value !== "all" ||
    category.value !== "all" ||
    aggregatableOnly.value,
);

function reset() {
  query.value = "";
  platform.value = "all";
  category.value = "all";
  aggregatableOnly.value = false;
}
</script>

<template>
  <section class="hc-explorer" aria-label="Health data type explorer">
    <div class="hc-explorer__controls">
      <div class="hc-explorer__search">
        <label class="hc-sr-only" for="hc-datatype-search">Search health data types</label>
        <svg class="hc-explorer__icon" viewBox="0 0 20 20" aria-hidden="true">
          <circle cx="9" cy="9" r="6" />
          <path d="M13.5 13.5 17 17" />
        </svg>
        <input
          id="hc-datatype-search"
          v-model="query"
          type="search"
          autocomplete="off"
          :placeholder="`Search ${dataset.totals.dataTypes} data types — try “heart”, “sleep”, or “Mass”`"
        />
      </div>

      <div class="hc-explorer__filters">
        <label class="hc-sr-only" for="hc-datatype-platform">Filter by platform</label>
        <select id="hc-datatype-platform" v-model="platform">
          <option v-for="filter in platformFilters" :key="filter.id" :value="filter.id">
            {{ filter.label }}
          </option>
        </select>

        <label class="hc-sr-only" for="hc-datatype-category">Filter by category</label>
        <select id="hc-datatype-category" v-model="category">
          <option value="all">All categories</option>
          <option v-for="name in dataset.categories" :key="name" :value="name">
            {{ name }}
          </option>
        </select>

        <label class="hc-explorer__toggle">
          <input v-model="aggregatableOnly" type="checkbox" />
          Aggregatable only
        </label>

        <button v-if="isFiltered" class="hc-explorer__reset" type="button" @click="reset">
          Clear
        </button>
      </div>
    </div>

    <p class="hc-explorer__count" role="status" aria-live="polite">
      <strong>{{ results.length }}</strong>
      of {{ dataset.totals.dataTypes }} data types
    </p>

    <p v-if="results.length === 0" class="hc-explorer__empty">
      No data type matches those filters. Try a broader search, or
      <button type="button" @click="reset">clear the filters</button>.
    </p>

    <div v-for="[groupName, entries] in grouped" :key="groupName" class="hc-explorer__group">
      <h3 class="hc-explorer__group-title">
        {{ groupName }}
        <span>{{ entries.length }}</span>
      </h3>

      <ul class="hc-explorer__list">
        <li v-for="entry in entries" :key="entry.constant" class="hc-type">
          <div class="hc-type__head">
            <h4>{{ entry.name }}</h4>
            <span class="hc-type__platforms">
              <span v-if="entry.android" class="hc-chip hc-chip--android">
                Health Connect<em v-if="entry.androidNote"> · {{ entry.androidNote }}</em>
              </span>
              <span v-if="entry.ios" class="hc-chip hc-chip--ios">
                HealthKit<em v-if="entry.iosNote"> · {{ entry.iosNote }}</em>
              </span>
            </span>
          </div>

          <p class="hc-type__description">{{ entry.description }}</p>

          <div class="hc-type__constant">
            <code>{{ entry.constant }}</code>
            <CopyButton :value="entry.constant" :label="`Copy ${entry.constant}`" />
          </div>

          <dl class="hc-type__meta">
            <div>
              <dt>Aggregation</dt>
              <dd>
                <template v-if="entry.aggregations.length">
                  <span v-for="name in entry.aggregations" :key="name" class="hc-chip">
                    {{ name }}
                  </span>
                </template>
                <span v-else class="hc-type__none">Not aggregatable</span>
              </dd>
            </div>
            <div>
              <dt>Native APIs</dt>
              <dd class="hc-type__native">
                <a
                  v-if="entry.androidApi?.url"
                  :href="entry.androidApi.url"
                  target="_blank"
                  rel="noreferrer"
                >{{ entry.androidApi.label }}</a>
                <span v-else-if="entry.androidApi">{{ entry.androidApi.label }}</span>
                <a
                  v-if="entry.iosApi?.url"
                  :href="entry.iosApi.url"
                  target="_blank"
                  rel="noreferrer"
                >{{ entry.iosApi.label }}</a>
                <span v-else-if="entry.iosApi">{{ entry.iosApi.label }}</span>
              </dd>
            </div>
          </dl>
        </li>
      </ul>
    </div>
  </section>
</template>
