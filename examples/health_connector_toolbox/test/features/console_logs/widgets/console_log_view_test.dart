import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorLogLevel;
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:health_connector_toolbox/src/features/console_logs/widgets/console_log_view.dart';

import '../utils/in_memory_console_log_storage.dart';

void main() {
  testWidgets('shows the empty text when there are no entries', (tester) async {
    // Given a console with no entries.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ConsoleLogView(entries: [], height: 200, emptyText: 'Empty'),
        ),
      ),
    );

    // Then the empty text is displayed.
    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('renders one line per entry and expands details on tap', (
    tester,
  ) async {
    // Given two entries, one with an operation.
    final entries = [
      buildEntry(id: 'a', timestamp: DateTime(2026, 9, 16, 8), message: 'one'),
      ConsoleLogEntry(
        id: 'b',
        timestamp: DateTime(2026, 9, 16, 8, 0, 1),
        level: HealthConnectorLogLevel.error,
        tag: 'Tag',
        message: 'two',
        origin: 'android_healthConnect',
        isolate: ConsoleLogIsolate.background,
        operation: 'synchronize',
        exception: 'StateError: broken',
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ConsoleLogView(entries: entries, height: 300),
        ),
      ),
    );

    // Then both formatted lines are visible and details are collapsed.
    expect(find.textContaining('one'), findsOneWidget);
    expect(find.textContaining('synchronize: two'), findsOneWidget);
    expect(find.textContaining('Origin: android_healthConnect'), findsNothing);

    // When the second line is tapped.
    await tester.tap(find.textContaining('synchronize: two'));
    await tester.pumpAndSettle();

    // Then its details are shown.
    expect(
      find.textContaining('Origin: android_healthConnect'),
      findsOneWidget,
    );
    expect(find.textContaining('Isolate: background'), findsOneWidget);
    expect(
      find.textContaining('Exception: StateError: broken'),
      findsOneWidget,
    );
  });
}
