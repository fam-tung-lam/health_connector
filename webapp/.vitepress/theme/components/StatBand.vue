<script setup lang="ts">
import dataset from "../../data/health-data-types.json";

const stats = [
  { value: `${dataset.totals.dataTypes}`, label: "typed health data types" },
  { value: `${dataset.totals.exerciseTypes}`, label: "exercise types" },
  { value: `${dataset.totals.aggregatable}`, label: "aggregatable on device" },
  { value: "0", label: "bytes logged by default" },
];
</script>

<template>
  <dl class="hc-stats">
    <div v-for="stat in stats" :key="stat.label">
      <dt>{{ stat.value }}</dt>
      <dd>{{ stat.label }}</dd>
    </div>
  </dl>
</template>
