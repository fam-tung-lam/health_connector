<script setup lang="ts">
defineProps<{
  title?: string;
  links: { text: string; link: string; description?: string }[];
}>();

const isExternal = (link: string) => /^https?:\/\//.test(link);
</script>

<template>
  <nav class="hc-next" :aria-label="title || 'Next steps'">
    <!-- An empty title lets the page supply its own surrounding heading. -->
    <h2 v-if="title !== ''" class="hc-next__title">{{ title ?? "Next steps" }}</h2>
    <ul>
      <li v-for="item in links" :key="item.link">
        <a
          :href="item.link"
          :target="isExternal(item.link) ? '_blank' : undefined"
          :rel="isExternal(item.link) ? 'noreferrer' : undefined"
        >
          <strong>{{ item.text }}</strong>
          <span v-if="item.description">{{ item.description }}</span>
        </a>
      </li>
    </ul>
  </nav>
</template>
