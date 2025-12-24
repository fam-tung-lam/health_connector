import 'package:health_connector_core/health_connector_core_internal.dart'
    show Percentage, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PercentageDto, PercentageUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Percentage] to [PercentageDto].
@sinceV1_0_0
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
@sinceV1_0_0
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
