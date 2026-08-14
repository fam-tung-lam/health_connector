<template>
  <figure class="hc-bridge" role="img" aria-labelledby="hc-bridge-title hc-bridge-description">
    <figcaption id="hc-bridge-title" class="hc-sr-only">Health Connector platform bridge</figcaption>
    <p id="hc-bridge-description" class="hc-sr-only">
      Your mobile app exchanges typed health requests and records with the Health Connector SDK. The
      SDK connects separately to Android Health Connect and Apple HealthKit.
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
        <div>
          <span>YOUR MOBILE APP</span>
          <strong>Flutter app</strong>
        </div>
      </div>

      <div class="hc-bridge__exchange">
        <svg viewBox="0 0 30 48">
          <path d="M15 7v34M10 12l5-5 5 5M10 36l5 5 5-5" />
        </svg>
        <span>typed requests &amp; shared records</span>
      </div>

      <div class="hc-bridge__stage hc-bridge__stage--sdk">
        <img src="/logo.svg" alt="" />
        <div>
          <span>HEALTH CONNECTOR SDK</span>
          <strong>HealthConnector</strong>
          <code>read · write · sync · aggregate</code>
        </div>
      </div>

      <div class="hc-bridge__route">
        <span>native platform adapters</span>
        <svg viewBox="0 0 320 54">
          <defs>
            <marker id="hc-arrow" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto">
              <path d="M0 0l6 3-6 3z" />
            </marker>
          </defs>
          <path d="M160 0v18" />
          <path d="M160 18H75v31" marker-end="url(#hc-arrow)" />
          <path d="M160 18h85v31" marker-end="url(#hc-arrow)" />
          <circle cx="160" cy="18" r="4" />
        </svg>
      </div>

      <div class="hc-bridge__platforms">
        <div class="hc-platform hc-platform--android">
          <span class="hc-platform__icon">A</span>
          <div><strong>Health Connect</strong><small>Android 8.0+</small></div>
        </div>
        <div class="hc-platform hc-platform--ios">
          <span class="hc-platform__icon">iOS</span>
          <div><strong>HealthKit</strong><small>iOS 15+</small></div>
        </div>
      </div>
    </div>
  </figure>
</template>
