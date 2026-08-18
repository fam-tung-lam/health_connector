<script setup lang="ts">
import DefaultTheme from "vitepress/theme";
import { useData } from "vitepress";
import HealthBridge from "./components/HealthBridge.vue";

const { Layout } = DefaultTheme;
const { frontmatter } = useData();
</script>

<template>
  <Layout>
    <template #home-hero-image><HealthBridge /></template>

    <template #aside-outline-after>
      <div v-if="frontmatter.layout !== 'home'" class="hc-aside-help">
        <h3>Stuck on this page?</h3>
        <a href="https://github.com/fam-tung-lam/health_connector/issues/new" target="_blank" rel="noreferrer">
          Open a GitHub issue
        </a>
        <a href="/reference/api-cheat-sheet">
          Browse the API cheat sheet
        </a>
      </div>
    </template>
  </Layout>
</template>
