import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/toolbox_operations_section.dart';

void main() {
  testWidgets('shows privacy before all SDK operations', (tester) async {
    // Given the toolbox operations displayed on the home screen.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ToolboxOperationsSection(
              onOpenPrivacy: () {},
              onOpenPermissions: () {},
              onOpenRecords: () {},
              onOpenWrite: () {},
              onOpenAggregation: () {},
              onOpenSync: () {},
              onOpenConsoleLogs: () {},
            ),
          ),
        ),
      ),
    );

    // When the section is displayed.
    await tester.pumpAndSettle();

    // Then privacy precedes the complete SDK operation list.
    expect(find.text('Privacy & Data'), findsOneWidget);
    expect(find.text('SDK Operations'), findsOneWidget);
    expect(find.text('Request Permissions'), findsOneWidget);
    expect(find.text('Read Health Records'), findsOneWidget);
    expect(find.text('Insert Health Record'), findsOneWidget);
    expect(find.text('Read Aggregate Data'), findsOneWidget);
    expect(find.text('Incremental Data Sync'), findsOneWidget);
    expect(find.text('Diagnostics'), findsOneWidget);
    expect(find.text('SDK Console Logs'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Privacy & Data')).dy,
      lessThan(tester.getTopLeft(find.text('SDK Operations')).dy),
    );
    expect(
      tester.getTopLeft(find.text('Incremental Data Sync')).dy,
      lessThan(tester.getTopLeft(find.text('Diagnostics')).dy),
    );
  });
}
