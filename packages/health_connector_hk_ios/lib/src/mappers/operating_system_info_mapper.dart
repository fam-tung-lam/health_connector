import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Maps an iOS operating-system DTO to the domain model.
@sinceV3_11_0
@internal
extension OperatingSystemInfoDtoToDomain on OperatingSystemInfoDto {
  /// Converts this DTO to an [IOSOperatingSystemInfo].
  IOSOperatingSystemInfo toDomain() => IOSOperatingSystemInfo(
    version: IOSVersion(majorVersion, minorVersion, patchVersion),
  );
}
