# Health Connector Toolbox store release

## Product identity

- App name: `Health Connector Toolbox`
- Version: `1.0.0` (`1`)
- Android application ID: `com.phamtunglam.healthconnector`
- Apple bundle ID: `com.phamtunglam.healthconnector`
- Default locale: English (United States)
- Price: Free
- Primary category: Health & Fitness
- Secondary Apple category: Developer Tools

## Store listing

App Store subtitle:

> Explore health SDK workflows

Google Play short description:

> Explore Health Connect and HealthKit SDK flows on a real device.

Full description:

> Health Connector Toolbox is an interactive health data explorer for Flutter
> developers. Try Health Connect on Android and HealthKit on iOS without cloning
> a repository or configuring a development environment.
>
> Choose the exact permissions you want to test, read records from a time range,
> create sample records, aggregate supported metrics, and inspect incremental
> synchronization behavior. The app keeps platform differences visible so you
> can see which SDK capabilities are available on each device.
>
> Your health data stays on your device. The Toolbox has no account, ads,
> analytics, or remote service. It reads only the data types you authorize and
> never uploads health records.
>
> This app is a developer utility. It does not provide medical advice,
> diagnosis, treatment, or emergency services.

Keywords for App Store Connect:

`flutter,healthkit,health connect,developer,sdk,health data,testing`

What's new:

> Initial public release with permission, read, write, aggregation, deletion,
> feature-status, and incremental-sync demonstrations.

## URLs

- Privacy policy: `https://health-connector.phamtunglam.com/legal/toolbox-privacy`
- Support: `https://health-connector.phamtunglam.com/resources/toolbox`
- Marketing: `https://health-connector.phamtunglam.com`

## Privacy declarations

- Apple App Privacy: No data collected.
- Google Play Data safety: No data collected and no data shared.
- Health data is processed on device and is never transmitted off device.
- No account, ads, analytics, tracking, crash reporting, or remote service.

## Review notes

> No account or login is required. On first launch, the app initializes the
> platform health service. Open Permissions, select one or more data types, and
> approve the system permission sheet. Read Records queries the chosen time
> range. Write Records saves only the sample record entered by the reviewer.
> Health data never leaves the device. The Privacy & Data card on the home screen
> explains storage and deletion. This is a developer utility and provides no
> medical advice.

## Android release signing

Release builds accept the ignored `android/key.properties` file or the
`HEALTH_CONNECTOR_UPLOAD_STORE_FILE`, `HEALTH_CONNECTOR_UPLOAD_STORE_PASSWORD`,
`HEALTH_CONNECTOR_UPLOAD_KEY_ALIAS`, and
`HEALTH_CONNECTOR_UPLOAD_KEY_PASSWORD` environment variables. Keep the upload
keystore outside Git and back it up separately from this checkout.

## Submission gates

- Accept the current Apple Developer Program License Agreement.
- Publish the privacy-policy page before entering its URL in either store.
- Complete Google's Health apps declaration for every requested Health Connect
  data type and explain its user-facing Toolbox flow.
- If Play Console requires it, keep at least 12 testers opted in to the closed
  test continuously for 14 days before applying for production access.
- Obtain explicit approval before uploading builds or submitting either app.
