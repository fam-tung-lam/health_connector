import 'package:health_connector_core/health_connector_core_internal.dart'
    show Percentage;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PercentageDto, PercentageUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Percentage] to [PercentageDto].
@internal
extension PercentageToDto on Percentage {
  PercentageDto toDto() {
    // Uses decimal as the transfer unit for consistency.
    return PercentageDto(
      value: asDecimal,
      unit: PercentageUnitDto.decimal,
    );
  }
}

/// Converts [PercentageDto] to [Percentage].
@internal
extension PercentageDtoToDomain on PercentageDto {
  Percentage toDomain() {
    switch (unit) {
      case PercentageUnitDto.decimal:
        return Percentage.fromDecimal(value);
      case PercentageUnitDto.whole:
        return Percentage.fromWhole(value);
    }
  }
}
