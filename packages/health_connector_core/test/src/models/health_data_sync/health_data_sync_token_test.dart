import 'package:health_connector_core/src/models/health_data_sync/health_data_sync_token.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:test/test.dart';

void main() {
  group('HealthDataSyncToken serialization', () {
    test('toJson uses snake_case ids from HealthDataType.id', () {
      final token = HealthDataSyncToken.internal(
        token: 'test_token',
        dataTypes: const [
          HealthDataType.steps,
          HealthDataType.activeEnergyBurned,
        ],
        createdAt: DateTime.utc(2026),
      );

      final json = token.toJson();

      expect(json['token'], 'test_token');
      expect(json['dataTypes'], ['steps', 'active_calories_burned']);
      expect(json['createdAt'], '2026-01-01T00:00:00.000Z');
    });

    test(
      'fromJson correctly reconstructs HealthDataSyncToken from '
      'snake_case ids',
      () {
        final json = {
          'token': 'test_token',
          'dataTypes': ['steps', 'active_calories_burned'],
          'createdAt': '2026-01-01T00:00:00.000Z',
        };

        final token = HealthDataSyncToken.fromJson(json);

        expect(token.token, 'test_token');
        expect(token.dataTypes, [
          HealthDataType.steps,
          HealthDataType.activeEnergyBurned,
        ]);
        expect(token.createdAt, DateTime.utc(2026));
      },
    );

    test('throws ArgumentError for unknown data type id', () {
      final json = {
        'token': 'test_token',
        'dataTypes': ['unknown_type'],
        'createdAt': '2026-01-01T00:00:00.000Z',
      };

      expect(() => HealthDataSyncToken.fromJson(json), throwsArgumentError);
    });
    test('HealthDataType.dataTypeMap contains all values', () {
      expect(HealthDataType.dataTypeMap.length, HealthDataType.values.length);
      for (final type in HealthDataType.values) {
        expect(HealthDataType.dataTypeMap[type.id], type);
      }
    });
  });
}
