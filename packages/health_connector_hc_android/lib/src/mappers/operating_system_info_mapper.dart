import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Maps an Android SDK Extension DTO to the domain model.
@sinceV4_0_0
@internal
extension AndroidSDKExtensionVersionDtoToDomain
    on AndroidSDKExtensionVersionDto {
  /// Converts this DTO to an [AndroidSDKExtensionVersion].
  AndroidSDKExtensionVersion toDomain() => AndroidSDKExtensionVersion(
    androidApiLevel: androidApiLevel,
    extensionVersion: extensionVersion,
  );
}

/// Maps an Android operating-system DTO to the domain model.
@sinceV4_0_0
@internal
extension OperatingSystemInfoDtoToDomain on OperatingSystemInfoDto {
  /// Converts this DTO to an [AndroidOperatingSystemInfo].
  AndroidOperatingSystemInfo toDomain() => AndroidOperatingSystemInfo(
    apiLevel: apiLevel,
    sdkExtensionVersions: List.unmodifiable(
      sdkExtensionVersions.map((version) => version.toDomain()),
    ),
  );
}
