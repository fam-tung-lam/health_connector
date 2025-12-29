part of 'metadata.dart';

/// Information about the device that recorded health data.
@sinceV1_0_0
@immutable
final class Device {
  /// Creates a device with the specified information.
  ///
  /// All fields except [type] are optional. This allows creating a device
  /// with varying levels of detail depending on what information is available.
  ///
  const Device({
    required this.type,
    this.name,
    this.manufacturer,
    this.model,
    this.hardwareVersion,
    this.firmwareVersion,
    this.softwareVersion,
    this.localIdentifier,
    this.udiDeviceIdentifier,
  });

  /// Creates a device with unknown type and no additional information.
  ///
  /// Use this when device information is completely unavailable or cannot be
  /// determined.
  ///
  /// Example:
  /// ```dart
  /// final device = Device.unknown();
  /// print(device.type); // DeviceType.unknown
  /// print(device.manufacturer); // null
  /// ```
  const Device.unknown()
    : type = DeviceType.unknown,
      name = null,
      manufacturer = null,
      model = null,
      hardwareVersion = null,
      firmwareVersion = null,
      softwareVersion = null,
      localIdentifier = null,
      udiDeviceIdentifier = null;

  /// Creates a device with only the type specified.
  ///
  /// Use this when you know the device type but don't have additional details
  /// like manufacturer or model.
  ///
  /// Example:
  /// ```dart
  /// final device = Device.fromType(DeviceType.phone);
  /// print(device.type); // DeviceType.phone
  /// print(device.manufacturer); // null
  /// ```
  const Device.fromType(DeviceType deviceType)
    : type = deviceType,
      name = null,
      manufacturer = null,
      model = null,
      hardwareVersion = null,
      firmwareVersion = null,
      softwareVersion = null,
      localIdentifier = null,
      udiDeviceIdentifier = null;

  /// The type of device (watch, phone, scale, etc.).
  final DeviceType type;

  /// The name of the device.
  ///
  /// Examples: "Apple Watch", "My Fitness Tracker", "iPhone"
  ///
  /// **Fallback behavior:** If `name` is `null`, the `model` value will be
  /// used as the device name when writing to HealthKit and Health Connect SDKs.
  final String? name;

  /// The manufacturer or brand of the device.
  ///
  /// Examples: "Apple", "Samsung", "Fitbit", "Withings"
  final String? manufacturer;

  /// The specific model of the device.
  ///
  /// Examples: "iPhone 15 Pro", "Galaxy Watch 6", "Pixel 8"
  final String? model;

  /// The hardware version of the device.
  ///
  /// Examples: "2.0", "A2484", "Rev 3"
  ///
  /// **Platform support:**
  /// - **iOS HealthKit:** Supported via `HKDevice.hardwareVersion`
  /// - **Android Health Connect:** Not supported
  final String? hardwareVersion;

  /// The firmware version of the device.
  ///
  /// Examples: "1.5.3", "2.1.0"
  ///
  /// **Platform support:**
  /// - **iOS HealthKit:** Supported via `HKDevice.firmwareVersion`
  /// - **Android Health Connect:** Not supported
  final String? firmwareVersion;

  /// The software version of the device.
  ///
  /// Examples: "4.2.1", "watchOS 10.0"
  ///
  /// **Platform support:**
  /// - **iOS HealthKit:** Supported via `HKDevice.softwareVersion`
  /// - **Android Health Connect:** Not supported
  final String? softwareVersion;

  /// A local identifier for the device.
  ///
  /// This is a device-specific identifier that may be used for local tracking
  /// or correlation purposes.
  ///
  /// **Platform support:**
  /// - **iOS HealthKit:** Supported via `HKDevice.localIdentifier`
  /// - **Android Health Connect:** Not supported
  final String? localIdentifier;

  /// The UDI (Unique Device Identifier) for the device.
  ///
  /// This is a globally unique identifier for medical devices, typically used
  /// for regulatory compliance.
  ///
  /// **Platform support:**
  /// - **iOS HealthKit:** Supported via `HKDevice.udiDeviceIdentifier`
  /// - **Android Health Connect:** Not supported
  final String? udiDeviceIdentifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          name == other.name &&
          manufacturer == other.manufacturer &&
          model == other.model &&
          hardwareVersion == other.hardwareVersion &&
          firmwareVersion == other.firmwareVersion &&
          softwareVersion == other.softwareVersion &&
          localIdentifier == other.localIdentifier &&
          udiDeviceIdentifier == other.udiDeviceIdentifier;

  @override
  int get hashCode =>
      type.hashCode ^
      name.hashCode ^
      manufacturer.hashCode ^
      model.hashCode ^
      hardwareVersion.hashCode ^
      firmwareVersion.hashCode ^
      softwareVersion.hashCode ^
      localIdentifier.hashCode ^
      udiDeviceIdentifier.hashCode;

  @override
  String toString() {
    final buffer = StringBuffer('Device(type: ${type.name}');

    if (name != null) {
      buffer.write(', name: $name');
    }

    if (manufacturer != null) {
      buffer.write(', manufacturer: $manufacturer');
    }

    if (model != null) {
      buffer.write(', model: $model');
    }

    if (hardwareVersion != null) {
      buffer.write(', hardwareVersion: $hardwareVersion');
    }

    if (firmwareVersion != null) {
      buffer.write(', firmwareVersion: $firmwareVersion');
    }

    if (softwareVersion != null) {
      buffer.write(', softwareVersion: $softwareVersion');
    }

    if (localIdentifier != null) {
      buffer.write(', localIdentifier: $localIdentifier');
    }

    if (udiDeviceIdentifier != null) {
      buffer.write(', udiDeviceIdentifier: $udiDeviceIdentifier');
    }

    buffer.write(')');
    return buffer.toString();
  }
}

/// The type of device that recorded the health data.
@sinceV1_0_0
enum DeviceType {
  /// Device type is unknown or cannot be determined.
  ///
  /// Use this when device information is not available or when the device
  /// doesn't fit into other categories.
  unknown,

  /// Smartwatch or fitness tracker worn on the wrist.
  ///
  /// Examples: Apple Watch, Samsung Galaxy Watch, Fitbit Sense
  watch,

  /// Smartphone or mobile device.
  ///
  /// Examples: iPhone, Android phone, tablet
  phone,

  /// Smart scale for measuring weight and body composition.
  ///
  /// Examples: Withings Body+, Fitbit Aria, Eufy Smart Scale
  scale,

  /// Smart ring worn on a finger.
  ///
  /// Examples: Oura Ring, Circular Ring
  ring,

  /// Fitness band or activity tracker.
  ///
  /// Examples: Fitbit Charge, Xiaomi Mi Band
  fitnessBand,

  /// Heart rate monitor chest strap.
  ///
  /// Examples: Polar H10, Wahoo TICKR
  chestStrap,

  /// Head-mounted device such as AR/VR headset.
  ///
  /// Examples: Meta Quest, Apple Vision Pro
  headMounted,

  /// Smart display or home hub device.
  ///
  /// Examples: Google Nest Hub, Amazon Echo Show
  smartDisplay,
}
