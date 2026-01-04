import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/temperature/basal_body_temperature_measurement_location_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

void main() {
  group('BasalBodyTemperatureMeasurementLocation Mapper', () {
    group('toDto', () {
      test('maps all domain values to DTO values correctly', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.unknown.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.unknown,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.armpit.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.armpit,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.ear.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.ear,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.finger.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.finger,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.forehead.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.forehead,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.mouth.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.mouth,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.rectum.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.rectum,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.temporalArtery.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.temporalArtery,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.toe.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.toe,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.vagina.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.vagina,
        );
        expect(
          BasalBodyTemperatureMeasurementLocation.wrist.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.wrist,
        );
      });
    });

    group('toDomain', () {
      test('maps all DTO values to domain values correctly', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.unknown.toDomain(),
          BasalBodyTemperatureMeasurementLocation.unknown,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.armpit.toDomain(),
          BasalBodyTemperatureMeasurementLocation.armpit,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.ear.toDomain(),
          BasalBodyTemperatureMeasurementLocation.ear,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.finger.toDomain(),
          BasalBodyTemperatureMeasurementLocation.finger,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.forehead.toDomain(),
          BasalBodyTemperatureMeasurementLocation.forehead,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.mouth.toDomain(),
          BasalBodyTemperatureMeasurementLocation.mouth,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.rectum.toDomain(),
          BasalBodyTemperatureMeasurementLocation.rectum,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.temporalArtery.toDomain(),
          BasalBodyTemperatureMeasurementLocation.temporalArtery,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.toe.toDomain(),
          BasalBodyTemperatureMeasurementLocation.toe,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.vagina.toDomain(),
          BasalBodyTemperatureMeasurementLocation.vagina,
        );
        expect(
          BasalBodyTemperatureMeasurementLocationDto.wrist.toDomain(),
          BasalBodyTemperatureMeasurementLocation.wrist,
        );
      });
    });
  });
}
