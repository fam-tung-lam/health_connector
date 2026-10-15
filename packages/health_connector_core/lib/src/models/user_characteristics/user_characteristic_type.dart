import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_platform_requirements/health_platform_requirement.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:health_connector_core/src/models/user_characteristics/biological_sex.dart';
import 'package:health_connector_core/src/models/user_characteristics/birt_date.dart';
import 'package:meta/meta.dart' show immutable;

/// A read-only user characteristic and its result type.
///
/// ## Platform Mapping
///
/// Supported only by iOS HealthKit. Android has no equivalent profile API.
///
/// {@category Core API}
@sinceV3_14_0
@immutable
sealed class UserCharacteristicType<T extends Object> {
  const UserCharacteristicType._();

  /// The person's Gregorian birth date.
  static const UserCharacteristicType<BirtDate> birthDate =
      BirthDateCharacteristicType._();

  /// The person's biological sex.
  static const UserCharacteristicType<BiologicalSex> biologicalSex =
      BiologicalSexCharacteristicType._();

  /// Permission to read this characteristic.
  UserCharacteristicPermission get readPermission =>
      UserCharacteristicPermission(characteristicType: this);

  /// Runtime platform requirements for this characteristic.
  List<HealthPlatformRequirement> get healthPlatformRequirements => const [
    AppleHealthRequirement.none,
  ];
}

/// @nodoc
@internalUse
final class BirthDateCharacteristicType
    extends UserCharacteristicType<BirtDate> {
  const BirthDateCharacteristicType._() : super._();
}

/// @nodoc
@internalUse
final class BiologicalSexCharacteristicType
    extends UserCharacteristicType<BiologicalSex> {
  const BiologicalSexCharacteristicType._() : super._();
}
