<template>
  <figure class="hc-bridge" role="img" aria-labelledby="hc-bridge-title hc-bridge-description">
    <figcaption id="hc-bridge-title" class="hc-sr-only">Health Connector SDK platform bridge</figcaption>
    <p id="hc-bridge-description" class="hc-sr-only">
      Your mobile app sends requests to the Health Connector SDK. The SDK routes each request
      separately to Android Health Connect and Apple HealthKit.
    </p>

    <div class="hc-bridge__bar" aria-hidden="true">
      <span>HEALTH DATA BRIDGE</span>
      <span class="hc-bridge__status"><i />TYPE SAFE</span>
    </div>

    <div class="hc-bridge__body" aria-hidden="true">
      <div class="hc-bridge__stage hc-bridge__stage--app">
        <span class="hc-bridge__stage-icon hc-bridge__stage-icon--phone">
          <svg viewBox="0 0 24 24">
            <rect x="6.5" y="2.5" width="11" height="19" rx="2.5" />
            <path d="M10 5.5h4M10.5 18.5h3" />
          </svg>
        </span>
        <strong>Your mobile app</strong>
      </div>

      <div class="hc-bridge__exchange">
        <svg viewBox="0 0 30 48">
          <path class="hc-arrow__line" d="M15 5v35" />
          <path class="hc-arrow__head" d="m10 35 5 6 5-6" />
        </svg>
      </div>

      <div class="hc-bridge__stage hc-bridge__stage--sdk">
        <img src="/logo.svg" alt="" />
        <strong>Health Connector SDK</strong>
      </div>

      <div class="hc-bridge__route">
        <svg viewBox="0 0 320 54">
          <path class="hc-arrow__line" d="M160 0v18" />
          <path class="hc-arrow__line" d="M160 18H75v30" />
          <path class="hc-arrow__line" d="M160 18h85v30" />
          <path class="hc-arrow__head" d="m70 43 5 6 5-6" />
          <path class="hc-arrow__head" d="m240 43 5 6 5-6" />
          <circle cx="160" cy="18" r="4" />
        </svg>
      </div>

      <div class="hc-bridge__platforms">
        <div class="hc-platform hc-platform--android">
          <span class="hc-platform__icon">
            <svg viewBox="0 0 24 24">
              <path d="M7 9h10v7.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 7 16.5V9Zm1.5 0a3.5 3.5 0 0 1 7 0M8.5 5.2 7.2 3.5m8.3 1.7 1.3-1.7M5 10.5v5m14-5v5M9 18v2m6-2v2" />
              <circle cx="10" cy="7.2" r=".7" />
              <circle cx="14" cy="7.2" r=".7" />
            </svg>
          </span>
          <strong>Health Connect</strong>
        </div>
        <div class="hc-platform hc-platform--ios">
          <span class="hc-platform__icon">
            <svg viewBox="0 0 24 24">
              <path d="M15.8 12.2c0-2 1.7-3 1.8-3.1-1-1.4-2.5-1.6-3-1.6-1.3-.1-2.5.8-3.2.8s-1.7-.8-2.8-.8c-1.4 0-2.8.9-3.5 2.1-1.5 2.6-.4 6.5 1.1 8.6.7 1 1.6 2.2 2.8 2.1 1.1 0 1.6-.7 3-.7s1.8.7 3 .7c1.2 0 2-1.1 2.7-2.2.8-1.2 1.2-2.4 1.3-2.5-.1 0-2.2-.8-2.2-3.4Zm-2-6c.6-.7 1-1.8.9-2.9-.9 0-2 .6-2.7 1.3-.6.7-1.1 1.7-1 2.7 1 .1 2.1-.5 2.8-1.1Z" />
            </svg>
          </span>
          <strong>HealthKit</strong>
        </div>
      </div>
    </div>
  </figure>
</template>
