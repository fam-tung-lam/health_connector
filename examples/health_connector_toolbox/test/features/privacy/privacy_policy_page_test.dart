import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart' show HealthPlatform;
import 'package:health_connector_toolbox/src/features/privacy/pages/privacy_policy_page.dart';

void main() {
  testWidgets('Apple Health privacy page excludes Health Connect details', (
    tester,
  ) async {
    // Given an Apple Health privacy page.
    tester.view.physicalSize = const Size(1200, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      const MaterialApp(
        home: PrivacyPolicyPage(
          healthPlatform: HealthPlatform.appleHealth,
        ),
      ),
    );

    // When the privacy information is displayed.
    await tester.pumpAndSettle();

    // Then every platform-specific disclosure identifies Apple HealthKit.
    expect(find.text('Your data stays on your device'), findsOneWidget);
    expect(find.textContaining('Apple Health'), findsWidgets);
    expect(find.textContaining('HealthKit'), findsWidgets);
    expect(
      find.textContaining(RegExp('Health Connect(?!or)')),
      findsNothing,
    );
    expect(find.textContaining('Android'), findsNothing);
    expect(find.textContaining('CareKit'), findsNothing);
  });

  testWidgets('Health Connect privacy page excludes Apple Health details', (
    tester,
  ) async {
    // Given a Health Connect privacy page.
    tester.view.physicalSize = const Size(1200, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      const MaterialApp(
        home: PrivacyPolicyPage(
          healthPlatform: HealthPlatform.healthConnect,
        ),
      ),
    );

    // When the privacy information is displayed.
    await tester.pumpAndSettle();

    // Then every platform-specific disclosure is about Health Connect.
    expect(
      find.textContaining(RegExp('Health Connect(?!or)')),
      findsWidgets,
    );
    expect(find.textContaining('Apple Health'), findsNothing);
    expect(find.textContaining('HealthKit'), findsNothing);
    expect(find.textContaining('iOS'), findsNothing);
  });

  testWidgets('privacy page shows local-data and support disclosures', (
    tester,
  ) async {
    // Given the privacy page for the active health platform.
    await tester.pumpWidget(
      const MaterialApp(
        home: PrivacyPolicyPage(
          healthPlatform: HealthPlatform.appleHealth,
        ),
      ),
    );

    // When support details are scrolled into view.
    await tester.scrollUntilVisible(
      find.textContaining('fam.tung.lam@gmail.com'),
      300,
    );

    // Then local-storage and safe-support disclosures are available.
    expect(find.text('Local app storage'), findsOneWidget);
    expect(find.textContaining('fam.tung.lam@gmail.com'), findsOneWidget);
    expect(find.textContaining('Do not send health records'), findsOneWidget);
  });
}
