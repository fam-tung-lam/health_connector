import 'package:health_connector_core/health_connector_core_internal.dart'
    show SkinTemperatureDeltaSample, Temperature, sinceV3_6_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SkinTemperatureDeltaSampleDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SkinTemperatureDeltaSample] to [SkinTemperatureDeltaSampleDto].
@sinceV3_6_0
@internal
extension SkinTemperatureDeltaToDto on SkinTemperatureDeltaSample {
  SkinTemperatureDeltaSampleDto toDto() {
    return SkinTemperatureDeltaSampleDto(
      time: time.millisecondsSinceEpoch,
      temperatureDeltaCelsius: temperatureDelta.inCelsius,
    );
  }
}

/// Converts [SkinTemperatureDeltaSampleDto] to [SkinTemperatureDeltaSample].
@sinceV3_6_0
@internal
extension SkinTemperatureDeltaDtoToDomain on SkinTemperatureDeltaSampleDto {
  SkinTemperatureDeltaSample toDomain() {
    return SkinTemperatureDeltaSample(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      temperatureDelta: Temperature.celsius(temperatureDeltaCelsius),
    );
  }
}
