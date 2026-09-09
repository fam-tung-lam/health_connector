# Health Connector Toolbox store release

## Product identity

- App name: `Health Connector Toolbox`
- Version: `1.0.0` (`4`)
- Android application ID: `com.phamtunglam.healthconnector`
- Apple bundle ID: `com.phamtunglam.healthconnector`
- Default locale: English (United States)
- Price: Free
- Google Play category: Health & Fitness
- Apple primary category: Health & Fitness
- Apple secondary category: Developer Tools

## Store listing

App Store subtitle:

> Private health data inspector

Google Play short description:

> Privately inspect, summarize, and add health data on your device.

App Store description:

> Health Connector Toolbox uses Apple's HealthKit framework to help you inspect
> and manage health data stored in the Health app on your iPhone or iPad.
>
> Choose exactly which data types the app can access. Browse records over a time
> range, view totals and averages for supported metrics, add health entries, and
> delete entries created by the Toolbox.
>
> SDK Operations on the main screen show permission state, mapped record
> metadata, supported writes and aggregation operations, and incremental sync
> behavior. These operations never expand the permissions you choose.
>
> Your health data stays on your device. The Toolbox has no account, ads,
> analytics, tracking, or remote service. It never uploads health records. The
> app does not provide medical advice, diagnosis, treatment, or emergency
> services.

Keywords for App Store Connect:

`health data,health records,apple health,healthkit,wellness,inspector,privacy`

Google Play full description:

> Health Connector Toolbox helps you inspect and manage the health data already
> stored in Health Connect on your Android device.
>
> Choose exactly which data types the app can access. Browse records over a time
> range, view totals and averages for supported metrics, add health entries, and
> delete entries created by the Toolbox.
>
> SDK Operations on the main screen show permission state, mapped record
> metadata, supported writes and aggregation operations, and incremental sync
> behavior. These operations never expand the permissions you choose.
>
> Your health data stays on your device. The Toolbox has no account, ads,
> analytics, tracking, or remote service. It never uploads health records. The
> app does not provide medical advice, diagnosis, treatment, or emergency
> services.

What's new:

> Initial public release for browsing, summarizing, adding, and managing
> on-device health data with SDK operation tools.

## URLs

- Privacy policy: `https://health-connector.phamtunglam.com/legal/toolbox-privacy`
- Support: `https://health-connector.phamtunglam.com/resources/toolbox`
- Marketing: `https://health-connector.phamtunglam.com`
- Private support email: `fam.tung.lam@gmail.com`

## Store assets

- Google Play icon: `assets/google_play_icon_512.png`
- Google Play feature graphic: `assets/google_play_feature_graphic_1024x500.png`
- Android phone screenshots: `screenshots/android/`
- iPhone screenshots, in upload order:
  - `screenshots/ios/iphone_17_pro_max/01_home.png`
  - `screenshots/ios/iphone_17_pro_max/02_data_access.png`
  - `screenshots/ios/iphone_17_pro_max/04_privacy.png`
- 13-inch iPad screenshots, in upload order:
  - `screenshots/ios/ipad_pro_13/01_home.png`
  - `screenshots/ios/ipad_pro_13/02_data_access.png`
  - `screenshots/ios/ipad_pro_13/03_summary.png`
  - `screenshots/ios/ipad_pro_13/04_privacy.png`

## Privacy declarations

- Apple App Privacy: No data collected.
- Google Play Data safety: No data collected and no data shared.
- Health data is processed on device and is never transmitted off device.
- No account, ads, analytics, tracking, crash reporting, or remote service.

## Review notes

> No account or login is required. On first launch, the app initializes the
> platform health service. Privacy & Data explains storage and deletion above
> the SDK Operations section. Request Permissions lets reviewers select data
> types and approve the system permission sheet. Read Health Records displays
> records for a chosen time range. Insert Health Record saves only the entry
> entered by the reviewer, and the app can delete only records it created. Read
> Aggregate Data calculates supported totals, averages, minimums, or maximums.
> Incremental Data Sync shows changes for authorized data types. Health data
> never leaves the device. The app provides no medical advice.
>
> This iOS build uses HealthKit only; it does not use CareKit. On launch, the
> Health Data Source card identifies the integration as "Apple Health
> (HealthKit)" and explains its authorized read, summary, write, and delete
> operations. The Privacy & Data page provides the same HealthKit disclosure.

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
  data type and connect each permission to a visible browse, summary, or entry
  feature.
- Keep SDK Operations limited to the user's on-device health data and selected
  permissions. They must not expand access.
- If Play Console requires it, keep at least 12 testers opted in to the closed
  test continuously for 14 days before applying for production access.
- Obtain explicit approval before uploading builds or submitting either app.
