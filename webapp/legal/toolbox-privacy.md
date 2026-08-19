# Health Connector Toolbox privacy policy

**Effective August 19, 2026**

Health Connector Toolbox is a personal health-data inspector that lets you
browse, summarize, and add health entries stored in Apple Health or Health
Connect. It also includes optional developer tools that show technical details
for those same on-device flows. It does not create an account, show ads, run
analytics, or send health data to Pham Tung Lam or any third party.

## Health data access

The app reads health records directly from Apple Health or Health Connect only
after you select specific permissions and approve the platform prompt. The
Toolbox groups supported data into these categories:

| Category | Data types | Available operations |
| --- | --- | --- |
| Activity and fitness | Calories burned, activity intensity, basal metabolic rate, distance, elevation, exercise and routes, floors climbed, power, speed, steps, VO2 max, and wheelchair pushes | Browse records, add entries, delete Toolbox-created records, and summarize supported measurements |
| Body measurements | Body fat, body water mass, bone mass, height, lean body mass, and weight | Browse records, add entries, delete Toolbox-created records, and summarize supported measurements |
| Vitals | Basal, body, and skin temperature; blood glucose and pressure; heart rate, heart-rate variability, and resting heart rate; oxygen saturation; and respiratory rate | Browse records, add entries, delete Toolbox-created records, and summarize supported measurements |
| Nutrition | Hydration and nutrition | Browse records, add entries, and delete Toolbox-created records |
| Sleep and wellness | Sleep and mindfulness sessions | Browse records, add entries, delete Toolbox-created records, and summarize supported durations |
| Reproductive and sexual health | Cervical mucus, intermenstrual bleeding, menstruation, ovulation tests, and sexual activity | Browse records, add entries, and delete Toolbox-created records |

Android can also request access to health-data history when you explicitly
select that feature. The app does not request every permission at launch.
Records you choose to read are displayed in the app for the selected time range
and are not uploaded or retained by the Toolbox.

Records you create are written to Apple Health or Health Connect. They remain
in the platform health store until you delete them in the Toolbox or the
platform health app. The Toolbox can only delete records that it created.

## Local app data

The optional Developer Tools mode stores incremental synchronization tokens
locally on your device so you can continue inspecting changes. Developer Tools
does not unlock additional data or bypass the permissions you choose.
Uninstalling the Toolbox removes this local app data but does not delete records
already saved in Apple Health or Health Connect.

## Data collection, sharing, and retention

The Toolbox does not collect or share personal data, health data, diagnostics,
usage data, identifiers, or precise location. It has no remote service or user
account. Health data remains under the retention and security controls of Apple
Health or Health Connect. The operating system protects those stores and the
Toolbox runs inside the platform app sandbox. Because the Toolbox does not
transmit health data, it does not maintain a server-side copy or backup.

## Your controls

You can grant only the permissions needed for a feature and revoke them at any
time in Apple Health, Health Connect, or system settings. The Android app also
exposes the SDK permission-revocation operation. To remove data:

1. Delete Toolbox-created records in the Toolbox or the platform health app.
2. Revoke future access in Apple Health, Health Connect, or system settings.
3. Uninstall the Toolbox to remove its local synchronization tokens and app
   preferences. Uninstalling does not delete records already stored in the
   platform health store.

## Contact

Email [fam.tung.lam@gmail.com](mailto:fam.tung.lam@gmail.com) for private
support or privacy questions. Do not send health records, screenshots containing
health data, or other sensitive information.

For non-sensitive bug reports, use the public
[Health Connector SDK issue tracker](https://github.com/fam-tung-lam/health_connector/issues).
