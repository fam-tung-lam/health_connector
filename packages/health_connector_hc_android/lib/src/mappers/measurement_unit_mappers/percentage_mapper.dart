import 'package:health_connector_core/health_connector_core_internal.dart'
    show Percentage;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PercentageDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Percentage] to [PercentageDto].
@internal
extension PercentageToDto on Percentage {
  PercentageDto toDto() {
    // Uses decimal as the transfer unit for consistency.
    return PercentageDto(
      decimal: asDecimal,
    );
  }
}

/// Converts [PercentageDto] to [Percentage].
@internal
extension PercentageDtoToDomain on PercentageDto {
  Percentage toDomain() {
    return Percentage.fromDecimal(decimal);
  }
}
