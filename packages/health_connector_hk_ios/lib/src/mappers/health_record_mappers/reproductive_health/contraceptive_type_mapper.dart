import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ContraceptiveTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ContraceptiveType] to [ContraceptiveTypeDto].
@sinceV3_1_0
@internal
extension ContraceptiveTypeToDto on ContraceptiveType {
  ContraceptiveTypeDto toDto() {
    switch (this) {
      case ContraceptiveType.unknown:
        return ContraceptiveTypeDto.unknown;
      case ContraceptiveType.implant:
        return ContraceptiveTypeDto.implant;
      case ContraceptiveType.injection:
        return ContraceptiveTypeDto.injection;
      case ContraceptiveType.intrauterineDevice:
        return ContraceptiveTypeDto.intrauterineDevice;
      case ContraceptiveType.intravaginalRing:
        return ContraceptiveTypeDto.intravaginalRing;
      case ContraceptiveType.oral:
        return ContraceptiveTypeDto.oral;
      case ContraceptiveType.patch:
        return ContraceptiveTypeDto.patch;
    }
  }
}

/// Converts [ContraceptiveTypeDto] to [ContraceptiveType].
@sinceV3_1_0
@internal
extension ContraceptiveTypeDtoToDomain on ContraceptiveTypeDto {
  ContraceptiveType toDomain() {
    switch (this) {
      case ContraceptiveTypeDto.unknown:
        return ContraceptiveType.unknown;
      case ContraceptiveTypeDto.implant:
        return ContraceptiveType.implant;
      case ContraceptiveTypeDto.injection:
        return ContraceptiveType.injection;
      case ContraceptiveTypeDto.intrauterineDevice:
        return ContraceptiveType.intrauterineDevice;
      case ContraceptiveTypeDto.intravaginalRing:
        return ContraceptiveType.intravaginalRing;
      case ContraceptiveTypeDto.oral:
        return ContraceptiveType.oral;
      case ContraceptiveTypeDto.patch:
        return ContraceptiveType.patch;
    }
  }
}
