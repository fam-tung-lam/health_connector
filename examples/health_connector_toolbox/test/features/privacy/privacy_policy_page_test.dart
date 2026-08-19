import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_toolbox/src/features/privacy/pages/privacy_policy_page.dart';

void main() {
  testWidgets('privacy page shows local-data and support disclosures', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: PrivacyPolicyPage()),
    );

    expect(find.text('Your data stays on your device'), findsOneWidget);
    expect(find.text('Reading and displaying health data'), findsOneWidget);
    expect(find.text('Writing and deleting records'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.textContaining('fam.tung.lam@gmail.com'),
      300,
    );

    expect(find.textContaining('fam.tung.lam@gmail.com'), findsOneWidget);
    expect(find.textContaining('Do not send health records'), findsOneWidget);
  });
}
