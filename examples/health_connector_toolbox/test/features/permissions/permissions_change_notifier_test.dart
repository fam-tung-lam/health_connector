import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthPlatformFeature;
import 'package:health_connector_toolbox/src/features/permissions/permissions_change_notifier.dart';

void main() {
  test('Toolbox requests the history and background read features', () {
    expect(
      PermissionsChangeNotifier.healthPlatformFeatures,
      [
        HealthPlatformFeature.readHealthDataHistory,
        HealthPlatformFeature.readHealthDataInBackground,
      ],
    );
  });
}
