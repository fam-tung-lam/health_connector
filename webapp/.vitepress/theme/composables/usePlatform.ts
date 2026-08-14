import { ref, watch } from "vue";

export type Platform = "android" | "ios";

const STORAGE_KEY = "health-connector:platform";

/**
 * Module-level state so every `PlatformTabs` on the site switches together:
 * a developer integrating only HealthKit should never have to re-pick iOS.
 */
export const activePlatform = ref<Platform>("android");

let restored = false;

export function usePlatform() {
  if (!restored && typeof window !== "undefined") {
    restored = true;

    const stored = window.localStorage.getItem(STORAGE_KEY);
    if (stored === "android" || stored === "ios") {
      activePlatform.value = stored;
    } else if (/iPhone|iPad/.test(window.navigator.userAgent)) {
      // Only an actual iOS device is a signal. A Mac says nothing about the
      // target platform — most Flutter developers on macOS build for both.
      activePlatform.value = "ios";
    }

    watch(activePlatform, (platform) => {
      window.localStorage.setItem(STORAGE_KEY, platform);
    });
  }

  return { activePlatform };
}
