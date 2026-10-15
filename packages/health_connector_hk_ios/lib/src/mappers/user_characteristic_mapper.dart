import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts typed characteristic descriptors to wire identifiers.
@internal
extension UserCharacteristicTypeToDto on UserCharacteristicType<Object> {
  UserCharacteristicTypeDto toDto() => switch (this) {
    BirthDateCharacteristicType() => UserCharacteristicTypeDto.birthDate,
    BiologicalSexCharacteristicType() =>
      UserCharacteristicTypeDto.biologicalSex,
  };
}

/// Restores the canonical characteristic identity.
@internal
extension UserCharacteristicTypeDtoToDomain on UserCharacteristicTypeDto {
  UserCharacteristicType<Object> toDomain() => switch (this) {
    UserCharacteristicTypeDto.birthDate => UserCharacteristicType.birthDate,
    UserCharacteristicTypeDto.biologicalSex =>
      UserCharacteristicType.biologicalSex,
  };
}

/// Restores a date without a timezone conversion.
@internal
extension BirtDateDtoToDomain on BirtDateDto {
  BirtDate toDomain() => BirtDate(year: year, month: month, day: day);
}

/// Restores a biological-sex value.
@internal
extension BiologicalSexDtoToDomain on BiologicalSexDto {
  BiologicalSex toDomain() => switch (this) {
    BiologicalSexDto.female => BiologicalSex.female,
    BiologicalSexDto.male => BiologicalSex.male,
    BiologicalSexDto.other => BiologicalSex.other,
  };
}
