<script setup lang="ts">
/**
 * Rendered as structured HTML rather than an image so it reflows on narrow
 * screens, inherits the theme, and stays readable to a screen reader.
 */
const layers = [
  {
    id: "app",
    kicker: "You write this",
    title: "Your Flutter app",
    detail: "import 'package:health_connector/health_connector.dart';",
  },
  {
    id: "facade",
    kicker: "Facade",
    title: "health_connector",
    detail: "HealthConnector.create() · one API, platform detected for you",
  },
  {
    id: "core",
    kicker: "Shared vocabulary",
    title: "health_connector_core",
    detail: "Records · measurement units · permissions · exceptions · annotations",
  },
];

const adapters = [
  {
    id: "android",
    kicker: "Android adapter",
    title: "health_connector_hc_android",
    detail: "Kotlin · androidx.health.connect",
  },
  {
    id: "ios",
    kicker: "iOS adapter",
    title: "health_connector_hk_ios",
    detail: "Swift · HealthKit",
  },
];
</script>

<template>
  <figure class="hc-arch">
    <figcaption class="hc-sr-only">
      Layer diagram. Your Flutter app calls the health_connector facade, which builds on the shared
      health_connector_core vocabulary and delegates to one of two platform adapters:
      health_connector_hc_android over Kotlin and Health Connect, or health_connector_hk_ios over
      Swift and HealthKit. Each adapter communicates with native code over a generated Pigeon channel.
    </figcaption>

    <div aria-hidden="true">
      <div v-for="layer in layers" :key="layer.id" class="hc-arch__layer" :data-layer="layer.id">
        <span class="hc-arch__kicker">{{ layer.kicker }}</span>
        <strong>{{ layer.title }}</strong>
        <code>{{ layer.detail }}</code>
      </div>

      <p class="hc-arch__split">platform detection at create()</p>

      <div class="hc-arch__adapters">
        <div
          v-for="adapter in adapters"
          :key="adapter.id"
          class="hc-arch__layer hc-arch__layer--adapter"
          :data-layer="adapter.id"
        >
          <span class="hc-arch__kicker">{{ adapter.kicker }}</span>
          <strong>{{ adapter.title }}</strong>
          <code>{{ adapter.detail }}</code>
        </div>
      </div>

      <p class="hc-arch__split">type-safe Pigeon channel · DTOs generated for both sides</p>
    </div>
  </figure>
</template>
