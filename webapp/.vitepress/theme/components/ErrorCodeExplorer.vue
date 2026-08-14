<script setup lang="ts">
import { computed, ref } from "vue";
import { errorCodes } from "../../data/error-codes";
import CopyButton from "./CopyButton.vue";

const query = ref("");

const platformLabel = {
  both: "Android & iOS",
  android: "Android only",
  ios: "iOS only",
} as const;

/** Collapses `RATE_LIMIT_EXCEEDED`, `rateLimitExceeded`, and `rate limit` to one form. */
const normalize = (value: string) => value.toLowerCase().replace(/[^a-z0-9]/g, "");

const results = computed(() => {
  const raw = query.value.trim().toLowerCase();
  if (!raw) return errorCodes;

  // People paste whatever their stack trace showed: a qualified constant
  // (`HealthConnectorErrorCode.permissionNotGranted`), the wire value
  // (`RATE_LIMIT_EXCEEDED`), or just words. All three should land.
  const needles = [raw, raw.split(".").pop()!].filter(Boolean);
  const squashed = normalize(raw);

  return errorCodes.filter((entry) => {
    const text = `${entry.code} ${entry.exception} ${entry.cause} ${entry.recovery}`;
    const haystack = text.toLowerCase();

    if (needles.some((needle) => haystack.includes(needle))) return true;

    return squashed.length > 2 && normalize(text).includes(squashed);
  });
});
</script>

<template>
  <section class="hc-explorer" aria-label="Error code explorer">
    <div class="hc-explorer__controls">
      <div class="hc-explorer__search">
        <label class="hc-sr-only" for="hc-error-search">Search error codes</label>
        <svg class="hc-explorer__icon" viewBox="0 0 20 20" aria-hidden="true">
          <circle cx="9" cy="9" r="6" />
          <path d="M13.5 13.5 17 17" />
        </svg>
        <input
          id="hc-error-search"
          v-model="query"
          type="search"
          autocomplete="off"
          placeholder="Paste the code or exception you hit — e.g. “rateLimit”"
        />
      </div>
    </div>

    <p class="hc-explorer__count" role="status" aria-live="polite">
      <strong>{{ results.length }}</strong> of {{ errorCodes.length }} error codes
    </p>

    <p v-if="results.length === 0" class="hc-explorer__empty">
      No error code matches that search — check the spelling, or browse the full list by
      clearing the box.
    </p>

    <ul class="hc-explorer__list">
      <li v-for="entry in results" :key="entry.code" class="hc-error">
        <div class="hc-error__head">
          <code class="hc-error__code">{{ entry.code }}</code>
          <CopyButton :value="entry.code" :label="`Copy ${entry.code}`" />
          <span class="hc-error__flags">
            <span class="hc-chip">{{ platformLabel[entry.platform] }}</span>
            <span v-if="entry.developerError" class="hc-chip hc-chip--alert">Fix in your app config</span>
            <span v-else-if="entry.retryable" class="hc-chip hc-chip--ios">Retryable</span>
          </span>
        </div>

        <p class="hc-error__exception">
          Thrown as <code>{{ entry.exception }}</code>
        </p>

        <dl class="hc-error__body">
          <dt>Why it happens</dt>
          <dd>{{ entry.cause }}</dd>
          <dt>How to recover</dt>
          <dd>{{ entry.recovery }}</dd>
        </dl>
      </li>
    </ul>
  </section>
</template>
