<script setup lang="ts">
import { onBeforeUnmount, ref } from "vue";

const isAndroidNoticeVisible = ref(false);
let hideAndroidNoticeTimer: ReturnType<typeof setTimeout> | undefined;

function showAndroidNotice() {
  isAndroidNoticeVisible.value = true;
  scheduleAndroidNoticeHide();
}

function scheduleAndroidNoticeHide() {
  clearTimeout(hideAndroidNoticeTimer);
  hideAndroidNoticeTimer = setTimeout(hideAndroidNotice, 7000);
}

function pauseAndroidNoticeHide() {
  clearTimeout(hideAndroidNoticeTimer);
  hideAndroidNoticeTimer = undefined;
}

function hideAndroidNotice() {
  isAndroidNoticeVisible.value = false;
  pauseAndroidNoticeHide();
}

onBeforeUnmount(pauseAndroidNoticeHide);
</script>

<template>
  <section class="hc-toolbox-stores" aria-labelledby="hc-toolbox-stores-title">
    <div class="hc-toolbox-stores__heading">
      <p>Try it on your device</p>
      <h2 id="hc-toolbox-stores-title">Explore the SDK in Health Connector Toolbox</h2>
      <p>
        Test permissions, health records, aggregations, and synchronization on
        a real device without first creating a Flutter project.
      </p>
    </div>

    <div class="hc-toolbox-stores__buttons">
      <a
        class="hc-store-button hc-store-button--ios"
        href="https://apps.apple.com/us/app/health-connector-toolbox/id6803127460"
        target="_blank"
        rel="noreferrer"
        aria-label="Download Health Connector Toolbox on the App Store (opens in a new tab)"
      >
        <span class="hc-store-button__icon" aria-hidden="true">
          <svg viewBox="0 0 64 64">
            <circle cx="32" cy="32" r="29" />
            <path d="m23 45 19-33M22 19l15 26M16 39h32" />
          </svg>
        </span>
        <span class="hc-store-button__label">
          <span>Available now</span>
          <strong>App Store</strong>
          <small>iOS &amp; iPadOS</small>
        </span>
      </a>

      <button
        class="hc-store-button hc-store-button--android"
        type="button"
        aria-controls="hc-android-store-notice"
        :aria-expanded="isAndroidNoticeVisible"
        @click="showAndroidNotice"
      >
        <span class="hc-store-button__icon" aria-hidden="true">
          <svg viewBox="0 0 64 64">
            <path fill="#00d7fe" d="M14 9v46l25-23z" />
            <path fill="#00ed76" d="m14 9 34 19-9 4z" />
            <path
              fill="#ffce00"
              d="m39 32 9-4 5 3a1.2 1.2 0 0 1 0 2l-5 3z"
            />
            <path fill="#ff4b55" d="m14 55 34-19-9-4z" />
          </svg>
        </span>
        <span class="hc-store-button__label">
          <span>Coming soon</span>
          <strong>Google Play</strong>
          <small>Android</small>
        </span>
      </button>
    </div>

    <Transition name="hc-snackbar">
      <div
        v-if="isAndroidNoticeVisible"
        id="hc-android-store-notice"
        class="hc-store-snackbar"
        role="status"
        aria-live="polite"
        @mouseenter="pauseAndroidNoticeHide"
        @mouseleave="scheduleAndroidNoticeHide"
        @focusin="pauseAndroidNoticeHide"
        @focusout="scheduleAndroidNoticeHide"
      >
        <span class="hc-store-snackbar__icon" aria-hidden="true">i</span>
        <span>
          <strong>Google Play release in progress</strong>
          <span>
            The Android app is coming soon. You can
            <a href="/resources/toolbox#run-the-source-version">
              run it from source
            </a>
            today.
          </span>
        </span>
        <button
          type="button"
          aria-label="Dismiss Google Play notice"
          @click="hideAndroidNotice"
        >
          <svg viewBox="0 0 20 20" aria-hidden="true">
            <path d="m5 5 10 10M15 5 5 15" />
          </svg>
        </button>
      </div>
    </Transition>
  </section>
</template>
