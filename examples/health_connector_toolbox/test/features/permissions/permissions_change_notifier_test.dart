import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthPlatformFeature;
import 'package:health_connector_toolbox/src/features/permissions/permissions_change_notifier.dart';

void main() {
  test('Toolbox requests only the health-data-history platform feature', () {
    expect(
      PermissionsChangeNotifier.healthPlatformFeatures,
      [HealthPlatformFeature.readHealthDataHistory],
    );
  });
}
