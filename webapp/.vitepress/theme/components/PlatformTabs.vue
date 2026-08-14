<script setup lang="ts">
import { usePlatform, type Platform } from "../composables/usePlatform";

const { activePlatform } = usePlatform();

const tabs: { id: Platform; label: string }[] = [
  { id: "android", label: "Android · Health Connect" },
  { id: "ios", label: "iOS · HealthKit" },
];

function onKeydown(event: KeyboardEvent) {
  if (event.key !== "ArrowLeft" && event.key !== "ArrowRight") return;

  event.preventDefault();
  activePlatform.value = activePlatform.value === "android" ? "ios" : "android";
  (event.currentTarget as HTMLElement)
    .querySelector<HTMLElement>('[aria-selected="true"]')
    ?.focus();
}
</script>

<template>
  <div class="hc-tabs">
    <div class="hc-tabs__list" role="tablist" aria-label="Platform" @keydown="onKeydown">
      <button
        v-for="tab in tabs"
        :id="`hc-tab-${tab.id}`"
        :key="tab.id"
        class="hc-tabs__tab"
        type="button"
        role="tab"
        :tabindex="activePlatform === tab.id ? 0 : -1"
        :aria-selected="activePlatform === tab.id"
        :aria-controls="`hc-panel-${tab.id}`"
        @click="activePlatform = tab.id"
      >
        {{ tab.label }}
      </button>
    </div>

    <div
      v-for="tab in tabs"
      v-show="activePlatform === tab.id"
      :id="`hc-panel-${tab.id}`"
      :key="tab.id"
      class="hc-tabs__panel"
      role="tabpanel"
      tabindex="0"
      :aria-labelledby="`hc-tab-${tab.id}`"
    >
      <slot :name="tab.id" />
    </div>
  </div>
</template>
