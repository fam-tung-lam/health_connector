import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart' show HealthDataType;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';

void main() {
  test('round-trips through JSON', () {
    // Given enabled settings with two data types.
    const settings = BackgroundSyncSettings(
      dataTypes: [HealthDataType.steps, HealthDataType.weight],
      isEnabled: true,
    );

    // When serialized and restored.
    final restored = BackgroundSyncSettings.fromJson(settings.toJson());

    // Then every field survives.
    expect(restored, settings);
    expect(restored.dataTypeIds, ['steps', 'weight']);
  });

  test('skips unknown data type ids and applies defaults', () {
    // Given JSON with an unknown id and no optional fields.
    final restored = BackgroundSyncSettings.fromJson(const {
      'dataTypes': ['steps', 'not_a_type'],
    });

    // Then only the known type is kept and defaults apply.
    expect(restored.dataTypes, [HealthDataType.steps]);
    expect(restored.isEnabled, isFalse);
  });

  test('copyWith replaces only the given fields', () {
    // Given default settings.
    const settings = BackgroundSyncSettings();

    // When only the enabled flag changes.
    final copy = settings.copyWith(isEnabled: true);

    // Then the rest is unchanged.
    expect(copy.isEnabled, isTrue);
    expect(copy.dataTypes, isEmpty);
  });
}
