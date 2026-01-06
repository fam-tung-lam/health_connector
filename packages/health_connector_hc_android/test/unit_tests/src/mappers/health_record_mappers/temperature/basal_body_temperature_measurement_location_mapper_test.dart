import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/basal_body_temperature_measurement_location_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group('BasalBodyTemperatureMeasurementLocationMapper', () {
    group('toDto', () {
      test('converts unknown to unknown', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.unknown.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.unknown,
        );
      });

      test('converts armpit to armpit', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.armpit.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.armpit,
        );
      });

      test('converts ear to ear', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.ear.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.ear,
        );
      });

      test('converts finger to finger', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.finger.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.finger,
        );
      });

      test('converts forehead to forehead', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.forehead.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.forehead,
        );
      });

      test('converts mouth to mouth', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.mouth.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.mouth,
        );
      });

      test('converts rectum to rectum', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.rectum.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.rectum,
        );
      });

      test('converts temporalArtery to temporalArtery', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.temporalArtery.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.temporalArtery,
        );
      });

      test('converts toe to toe', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.toe.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.toe,
        );
      });

      test('converts vagina to vagina', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.vagina.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.vagina,
        );
      });

      test('converts wrist to wrist', () {
        expect(
          BasalBodyTemperatureMeasurementLocation.wrist.toDto(),
          BasalBodyTemperatureMeasurementLocationDto.wrist,
        );
      });
    });

    group('toDomain', () {
      test('converts unknown to unknown', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.unknown.toDomain(),
          BasalBodyTemperatureMeasurementLocation.unknown,
        );
      });

      test('converts armpit to armpit', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.armpit.toDomain(),
          BasalBodyTemperatureMeasurementLocation.armpit,
        );
      });

      test('converts ear to ear', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.ear.toDomain(),
          BasalBodyTemperatureMeasurementLocation.ear,
        );
      });

      test('converts finger to finger', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.finger.toDomain(),
          BasalBodyTemperatureMeasurementLocation.finger,
        );
      });

      test('converts forehead to forehead', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.forehead.toDomain(),
          BasalBodyTemperatureMeasurementLocation.forehead,
        );
      });

      test('converts mouth to mouth', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.mouth.toDomain(),
          BasalBodyTemperatureMeasurementLocation.mouth,
        );
      });

      test('converts rectum to rectum', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.rectum.toDomain(),
          BasalBodyTemperatureMeasurementLocation.rectum,
        );
      });

      test('converts temporalArtery to temporalArtery', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.temporalArtery.toDomain(),
          BasalBodyTemperatureMeasurementLocation.temporalArtery,
        );
      });

      test('converts toe to toe', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.toe.toDomain(),
          BasalBodyTemperatureMeasurementLocation.toe,
        );
      });

      test('converts vagina to vagina', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.vagina.toDomain(),
          BasalBodyTemperatureMeasurementLocation.vagina,
        );
      });

      test('converts wrist to wrist', () {
        expect(
          BasalBodyTemperatureMeasurementLocationDto.wrist.toDomain(),
          BasalBodyTemperatureMeasurementLocation.wrist,
        );
      });
    });
  });
}
