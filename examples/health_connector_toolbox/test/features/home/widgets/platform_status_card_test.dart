import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart' show HealthPlatform;
import 'package:health_connector_toolbox/src/common/theme/app_theme_data.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/platform_status_card.dart';

void main() {
  testWidgets('Apple platform card identifies HealthKit functionality', (
    tester,
  ) async {
    // Given the Apple health platform status shown on the home screen.
    await tester.pumpWidget(
      MaterialApp(
        theme: appThemeData,
        home: const Scaffold(
          body: PlatformStatusCard(
            healthPlatform: HealthPlatform.appleHealth,
          ),
        ),
      ),
    );

    // When the platform status is displayed.
    await tester.pumpAndSettle();

    // Then HealthKit and its authorized functionality are explicit.
    expect(find.text('Apple Health (HealthKit)'), findsOneWidget);
    expect(find.textContaining('Uses HealthKit'), findsOneWidget);
    expect(find.textContaining('authorized data'), findsOneWidget);
  });

  testWidgets('Android platform card identifies Health Connect functionality', (
    tester,
  ) async {
    // Given the Android health platform status shown on the home screen.
    await tester.pumpWidget(
      MaterialApp(
        theme: appThemeData,
        home: const Scaffold(
          body: PlatformStatusCard(
            healthPlatform: HealthPlatform.healthConnect,
          ),
        ),
      ),
    );

    // When the platform status is displayed.
    await tester.pumpAndSettle();

    // Then Health Connect and its authorized functionality are explicit.
    expect(find.text('Health Connect'), findsOneWidget);
    expect(find.textContaining('Uses Health Connect'), findsOneWidget);
    expect(find.textContaining('authorized data'), findsOneWidget);
  });
}
