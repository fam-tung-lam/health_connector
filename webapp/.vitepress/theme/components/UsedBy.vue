<script setup lang="ts">
const apps = [
  {
    name: "Olho no Prato",
    url: "https://olhonoprato.app/",
    logo: "/apps/olho-no-prato.svg",
    description:
      "A nutrition app that turns meal photos into calorie and macro estimates, with health data synchronization.",
    creator: {
      name: "Felipe Valtl de Mello",
      role: "Principal Software Engineer at Transfeera",
      url: "https://www.linkedin.com/in/felipevaltldemello/",
    },
  },
];
</script>

<template>
  <section class="hc-used-by" aria-labelledby="hc-used-by-title">
    <div class="hc-used-by__heading">
      <p>In production</p>
      <h2 id="hc-used-by-title">Built with Health Connector</h2>
      <p>See how teams use the SDK in real products.</p>
    </div>

    <ul>
      <li v-for="app in apps" :key="app.url">
        <article class="hc-used-by__card">
          <a
            class="hc-used-by__app"
            :href="app.url"
            target="_blank"
            rel="noreferrer"
            :aria-label="`Visit ${app.name}`"
          >
            <img :src="app.logo" alt="" width="72" height="72" />
            <span>
              <strong>{{ app.name }}</strong>
              <span>{{ app.description }}</span>
            </span>
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <path d="M7 17 17 7M8 7h9v9" />
            </svg>
          </a>

          <p class="hc-used-by__creator">
            Created by
            <a :href="app.creator.url" target="_blank" rel="noreferrer">
              {{ app.creator.name }}
            </a>
            <span class="hc-used-by__separator" aria-hidden="true">·</span>
            <span class="hc-used-by__role">{{ app.creator.role }}</span>
          </p>
        </article>
      </li>
    </ul>
  </section>
</template>
