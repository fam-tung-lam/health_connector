import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart' show HealthPlatform;
import 'package:health_connector_toolbox/src/common/theme/app_theme_data.dart';
import 'package:health_connector_toolbox/src/features/developer_tools/pages/developer_tools_page.dart';

void main() {
  testWidgets(
    'shows SDK operations as optional tools for the selected health platform',
    (tester) async {
      // Given a developer tools page for Apple Health.
      await tester.pumpWidget(
        MaterialApp(
          theme: appThemeData,
          home: DeveloperToolsPage(
            healthPlatform: HealthPlatform.appleHealth,
            onOpenPermissions: () {},
            onOpenRecords: () {},
            onOpenWrite: () {},
            onOpenAggregation: () {},
            onOpenSync: () {},
          ),
        ),
      );

      // When the page is displayed.
      await tester.pumpAndSettle();

      // Then it identifies the connected platform and optional SDK tools.
      expect(find.text('Developer Tools'), findsOneWidget);
      expect(find.text('Apple Health'), findsOneWidget);
      expect(find.text('SDK Operations'), findsOneWidget);
      expect(find.text('Permissions API'), findsOneWidget);
    },
  );
}
