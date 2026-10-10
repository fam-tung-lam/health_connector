import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('DataOrigin', () {
    test('existing const construction has no display name', () {
      // Given
      const origin = DataOrigin('com.example.app');

      // Then
      expect(origin.packageName, 'com.example.app');
      expect(origin.displayName, isNull);
    });

    test('display names do not change source identity', () {
      // Given
      const unnamed = DataOrigin('com.example.app');
      const named = DataOrigin('com.example.app', displayName: 'Health App');
      const localized = DataOrigin(
        'com.example.app',
        displayName: 'Gesundheits-App',
      );

      // When
      final origins = {unnamed, named, localized};

      // Then
      expect(named.displayName, 'Health App');
      expect(localized, unnamed);
      expect(named.hashCode, unnamed.hashCode);
      expect(origins, hasLength(1));
      expect(
        named,
        isNot(const DataOrigin('com.other.app', displayName: 'Health App')),
      );
    });

    test('metadata copies retain the source display name', () {
      // Given
      final metadata = Metadata.internal(
        recordingMethod: RecordingMethod.manualEntry,
        dataOrigin: const DataOrigin(
          'com.example.app',
          displayName: 'Health App',
        ),
      );

      // When
      final copy = metadata.copyWith(clientRecordId: 'updated-client-id');

      // Then
      expect(copy.dataOrigin?.displayName, 'Health App');
      expect(copy.dataOrigin?.packageName, 'com.example.app');
      expect(copy.clientRecordId, 'updated-client-id');
    });
  });
}
