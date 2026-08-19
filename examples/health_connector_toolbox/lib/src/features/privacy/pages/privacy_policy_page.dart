import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Explains how the Toolbox accesses and stores health data.
@immutable
final class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.privacyAndData)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            _PrivacySection(
              title: 'Your data stays on your device',
              body:
                  'The Toolbox does not create an account, show ads, run '
                  'analytics, or send health data to Pham Tung Lam or any '
                  'third party. Health records are read directly from Apple '
                  'Health or Health Connect only after you grant access.',
            ),
            _PrivacySection(
              title: 'Reading and displaying health data',
              body:
                  'Records you choose to read are displayed in the app and '
                  'are not uploaded or retained by the Toolbox. The operating '
                  'system controls which data types the app can access.',
            ),
            _PrivacySection(
              title: 'Writing and deleting records',
              body:
                  'Records you create are saved to Apple Health or Health '
                  'Connect. They remain there until you delete them in the '
                  'Toolbox or the platform health app. The Toolbox can only '
                  'delete records that it created.',
            ),
            _PrivacySection(
              title: 'Local app storage',
              body:
                  'Incremental synchronization tokens are stored locally so '
                  'you can continue a sync demonstration. Uninstalling the '
                  'Toolbox removes this local app data but does not delete '
                  'records already saved in the platform health store.',
            ),
            _PrivacySection(
              title: 'Your controls',
              body:
                  'You can grant only the permissions needed for a feature. '
                  'You can revoke access at any time in Apple Health, Health '
                  'Connect, or system settings. The Android app also exposes '
                  'the SDK permission-revocation operation.',
            ),
            _PrivacySection(
              title: 'Support',
              body:
                  'For private support or privacy questions, email '
                  'fam.tung.lam@gmail.com. Do not send health records or '
                  'screenshots containing health data. Use the public Health '
                  'Connector SDK issue tracker only for non-sensitive bug '
                  'reports.',
            ),
            Text(
              'Effective August 19, 2026',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

final class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(body, style: textTheme.bodyMedium?.copyWith(height: 1.5)),
        ],
      ),
    );
  }
}
