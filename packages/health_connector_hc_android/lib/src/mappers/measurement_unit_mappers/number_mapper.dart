import 'package:health_connector_core/health_connector_core_internal.dart'
    show Number;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show NumberDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Number] to [NumberDto].
@internal
extension NumberToDto on Number {
  NumberDto toDto() {
    return NumberDto(
      value: value.toDouble(),
    );
  }
}

/// Converts [NumberDto] to [Number].
@internal
extension NumberDtoToDomain on NumberDto {
  Number toDomain() {
    return Number(value);
  }
}
