<script setup lang="ts">
import { computed, ref } from "vue";
import { data as dataset } from "../../data/catalog.data";
import CopyButton from "./CopyButton.vue";

const query = ref("");
const platform = ref<"all" | "android" | "ios" | "both">("all");

const results = computed(() => {
  const needle = query.value.trim().toLowerCase();

  return dataset.exerciseTypes.filter((entry) => {
    if (platform.value === "android" && !entry.android) return false;
    if (platform.value === "ios" && !entry.ios) return false;
    if (platform.value === "both" && !(entry.android && entry.ios)) return false;

    return !needle || `${entry.name} ${entry.constant}`.toLowerCase().includes(needle);
  });
});
</script>

<template>
  <section class="hc-explorer" aria-label="Exercise type explorer">
    <div class="hc-explorer__controls">
      <div class="hc-explorer__search">
        <label class="hc-sr-only" for="hc-exercise-search">Search exercise types</label>
        <svg class="hc-explorer__icon" viewBox="0 0 20 20" aria-hidden="true">
          <circle cx="9" cy="9" r="6" />
          <path d="M13.5 13.5 17 17" />
        </svg>
        <input
          id="hc-exercise-search"
          v-model="query"
          type="search"
          autocomplete="off"
          placeholder="Search exercise types — try “swim”, “yoga”, or “cycling”"
        />
      </div>

      <div class="hc-explorer__filters">
        <label class="hc-sr-only" for="hc-exercise-platform">Filter by platform</label>
        <select id="hc-exercise-platform" v-model="platform">
          <option value="all">All platforms</option>
          <option value="android">Health Connect</option>
          <option value="ios">HealthKit</option>
          <option value="both">Both</option>
        </select>
      </div>
    </div>

    <p class="hc-explorer__count" role="status" aria-live="polite">
      <strong>{{ results.length }}</strong>
      of {{ dataset.totals.exerciseTypes }} exercise types
    </p>

    <p v-if="results.length === 0" class="hc-explorer__empty">No exercise type matches that search.</p>

    <ul v-else class="hc-explorer__grid">
      <li v-for="entry in results" :key="entry.constant" class="hc-exercise">
        <div class="hc-exercise__name">
          <strong>{{ entry.name }}</strong>
          <CopyButton :value="entry.constant" :label="`Copy ${entry.constant}`" />
        </div>
        <code>{{ entry.constant }}</code>
        <div class="hc-exercise__platforms">
          <span v-if="entry.android" class="hc-chip hc-chip--android">Health Connect</span>
          <span v-if="entry.ios" class="hc-chip hc-chip--ios">HealthKit</span>
        </div>
      </li>
    </ul>
  </section>
</template>
