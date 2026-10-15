part of 'permission.dart';

/// Read permission for one iOS user characteristic.
///
/// HealthKit does not disclose read authorization status. A completed request
/// returns [PermissionStatus.unknown], even when access was granted.
///
/// {@category Permissions}
@sinceV3_14_0
@immutable
final class UserCharacteristicPermission extends Permission {
  /// Creates a characteristic permission.
  ///
  /// Prefer [UserCharacteristicType.readPermission].
  @internalUse
  const UserCharacteristicPermission({required this.characteristicType});

  /// The characteristic this permission allows the app to request.
  final UserCharacteristicType<Object> characteristicType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCharacteristicPermission &&
          characteristicType == other.characteristicType;

  @override
  int get hashCode => characteristicType.hashCode;
}
