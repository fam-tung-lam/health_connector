import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart'
    show HealthDataType, HealthPlatform;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/health_data_type_multi_select_bottom_sheet.dart';

void main() {
  late Future<List<HealthDataType>?> result;

  Future<void> openSheet(
    WidgetTester tester, {
    required HealthPlatform platform,
    List<HealthDataType> initialSelection = const [],
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                result = HealthDataTypeMultiSelectBottomSheet.show(
                  context,
                  healthPlatform: platform,
                  initialSelection: initialSelection,
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('lists only the data types of the platform', (tester) async {
    // Given the sheet opened for Health Connect.
    await openSheet(tester, platform: HealthPlatform.healthConnect);

    // Then every Health Connect type is a checkbox and no Apple-only type is.
    final expected = HealthDataTypeMultiSelectBottomSheet.availableDataTypes(
      HealthPlatform.healthConnect,
    );
    expect(expected, isNotEmpty);
    expect(find.byType(CheckboxListTile), findsWidgets);
    expect(find.text('Select Data Types (0)'), findsOneWidget);
    expect(
      HealthDataTypeMultiSelectBottomSheet.availableDataTypes(
        HealthPlatform.appleHealth,
      ),
      isNot(equals(expected)),
    );
  });

  testWidgets('search filters the list and Done returns the selection', (
    tester,
  ) async {
    // Given the sheet opened with weight pre-selected.
    await openSheet(
      tester,
      platform: HealthPlatform.healthConnect,
      initialSelection: const [HealthDataType.weight],
    );
    expect(find.text('Select Data Types (1)'), findsOneWidget);

    // When searching for steps and ticking it.
    await tester.enterText(find.byType(TextField), 'steps');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey(HealthDataType.steps.id)));
    await tester.pumpAndSettle();
    expect(find.text('Select Data Types (2)'), findsOneWidget);

    // And confirming.
    await tester.tap(find.text('Done (2)'));
    await tester.pumpAndSettle();

    // Then the selection contains both types sorted by display name.
    expect(await result, [HealthDataType.steps, HealthDataType.weight]);
  });

  testWidgets('cancel returns null', (tester) async {
    // Given the sheet is open.
    await openSheet(tester, platform: HealthPlatform.appleHealth);

    // When cancelled.
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Then nothing is returned.
    expect(await result, isNull);
  });
}
