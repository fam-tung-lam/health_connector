<script setup lang="ts">
import { ref } from "vue";

const props = defineProps<{ value: string; label?: string }>();

const copied = ref(false);
let timer: ReturnType<typeof setTimeout> | undefined;

async function copy() {
  try {
    await navigator.clipboard.writeText(props.value);
    copied.value = true;
    clearTimeout(timer);
    timer = setTimeout(() => (copied.value = false), 1600);
  } catch {
    // Clipboard access can be blocked; the text stays selectable either way.
  }
}
</script>

<template>
  <button
    class="hc-copy"
    type="button"
    :aria-label="label ?? `Copy ${value}`"
    :data-copied="copied"
    @click="copy"
  >
    <svg v-if="!copied" viewBox="0 0 20 20" aria-hidden="true">
      <rect x="7" y="7" width="9" height="10" rx="2" />
      <path d="M13 5.5A2.5 2.5 0 0 0 10.5 3h-4A2.5 2.5 0 0 0 4 5.5v6A2.5 2.5 0 0 0 6 14" />
    </svg>
    <svg v-else viewBox="0 0 20 20" aria-hidden="true"><path d="m4 10.5 4 4 8-9" /></svg>
  </button>
  <span class="hc-sr-only" role="status" aria-live="polite">
    {{ copied ? `Copied ${value}` : "" }}
  </span>
</template>
