import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_platform_feature_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'HealthPlatformFeatureMapper',
    () {
      group(
        'HealthPlatformFeatureToDto',
        () {
          parameterizedTest(
            'maps HealthPlatformFeature to HealthPlatformFeatureDto',
            [
              [
                HealthPlatformFeature.readDataHistory,
                HealthPlatformFeatureDto.readDataHistory,
              ],
              [
                HealthPlatformFeature.readDataInBackground,
                HealthPlatformFeatureDto.readDataInBackground,
              ],
            ],
            (HealthPlatformFeature domain, HealthPlatformFeatureDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'HealthPlatformFeatureDtoToDomain',
        () {
          parameterizedTest(
            'maps HealthPlatformFeatureDto to HealthPlatformFeature',
            [
              [
                HealthPlatformFeatureDto.readDataHistory,
                HealthPlatformFeature.readDataHistory,
              ],
              [
                HealthPlatformFeatureDto.readDataInBackground,
                HealthPlatformFeature.readDataInBackground,
              ],
            ],
            (HealthPlatformFeatureDto dto, HealthPlatformFeature domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );

      group(
        'HealthPlatformFeatureStatusDtoToDomain',
        () {
          parameterizedTest(
            'maps HealthPlatformFeatureStatusDto to '
            'HealthPlatformFeatureStatus',
            [
              [
                HealthPlatformFeatureStatusDto.available,
                HealthPlatformFeatureStatus.available,
              ],
              [
                HealthPlatformFeatureStatusDto.unavailable,
                HealthPlatformFeatureStatus.unavailable,
              ],
            ],
            (
              HealthPlatformFeatureStatusDto dto,
              HealthPlatformFeatureStatus domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );

      group(
        'HealthPlatformFeatureStatusToDto',
        () {
          parameterizedTest(
            'maps HealthPlatformFeatureStatus to '
            'HealthPlatformFeatureStatusDto',
            [
              [
                HealthPlatformFeatureStatus.available,
                HealthPlatformFeatureStatusDto.available,
              ],
              [
                HealthPlatformFeatureStatus.unavailable,
                HealthPlatformFeatureStatusDto.unavailable,
              ],
            ],
            (
              HealthPlatformFeatureStatus domain,
              HealthPlatformFeatureStatusDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );
    },
  );
}
