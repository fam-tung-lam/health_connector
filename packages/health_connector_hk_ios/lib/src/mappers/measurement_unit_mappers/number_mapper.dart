import 'package:health_connector_core/health_connector_core_internal.dart'
    show Number, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show NumberDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Number] to [NumberDto].
@sinceV1_0_0
@internal
extension NumberToDto on Number {
  NumberDto toDto() {
    return NumberDto(
      value: value.toDouble(),
    );
  }
}

/// Converts [NumberDto] to [Number].
@sinceV1_0_0
@internal
extension NumberDtoToDomain on NumberDto {
  Number toDomain() {
    return Number(value);
  }
}
