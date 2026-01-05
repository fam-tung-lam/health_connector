import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:health_connector_core/src/utils/permission_extension.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PermissionListExtension',
    () {
      const permissions = <Permission>[
        HealthDataPermission(
          dataType: HealthDataType.steps,
          accessType: HealthDataPermissionAccessType.read,
        ),
        HealthPlatformFeaturePermission(
          HealthPlatformFeature.readHealthDataHistory,
        ),
        HealthDataPermission(
          dataType: HealthDataType.heartRateSeriesRecord,
          accessType: HealthDataPermissionAccessType.write,
        ),
        HealthPlatformFeaturePermission(
          HealthPlatformFeature
              .readHealthDataHistory, // Duplicate type for test
        ),
      ];

      group(
        'healthDataPermissions',
        () {
          test(
            'returns only HealthDataPermission instances',
            () {
              final healthDataPermissions = permissions.healthDataPermissions;
              expect(healthDataPermissions.length, 2);
              expect(
                healthDataPermissions,
                everyElement(isA<HealthDataPermission>()),
              );
              expect(healthDataPermissions[0].dataType, HealthDataType.steps);
              expect(
                healthDataPermissions[1].dataType,
                HealthDataType.heartRateSeriesRecord,
              );
            },
          );

          test(
            'returns empty list if no HealthDataPermission instances',
            () {
              const onlyFeatures = <Permission>[
                HealthPlatformFeaturePermission(
                  HealthPlatformFeature.readHealthDataHistory,
                ),
              ];
              expect(onlyFeatures.healthDataPermissions, isEmpty);
            },
          );
        },
      );

      group(
        'featurePermissions',
        () {
          test(
            'returns only HealthPlatformFeaturePermission instances',
            () {
              final featurePermissions = permissions.featurePermissions;
              expect(featurePermissions.length, 2);
              expect(
                featurePermissions,
                everyElement(isA<HealthPlatformFeaturePermission>()),
              );
              expect(
                featurePermissions[0].feature,
                HealthPlatformFeature.readHealthDataHistory,
              );
            },
          );

          test(
            'returns empty list if no HealthPlatformFeaturePermission',
            () {
              const onlyHealthData = <Permission>[
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];
              expect(onlyHealthData.featurePermissions, isEmpty);
            },
          );
        },
      );
    },
  );
}
