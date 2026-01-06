import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';

void main() {
  group(
    'MeasurementUnitMapper',
    () {
      group(
        'MeasurementUnitDtoToDomain',
        () {
          test('maps MassDto to Mass', () {
            final dto = MassDto(kilograms: 70.0);
            expect(dto.toDomain(), const Mass.kilograms(70.0));
          });

          test('maps EnergyDto to Energy', () {
            final dto = EnergyDto(kilocalories: 2000.0);
            expect(dto.toDomain(), const Energy.kilocalories(2000.0));
          });

          test('maps TimeDurationDto to TimeDuration', () {
            final dto = TimeDurationDto(seconds: 60.0);
            expect(dto.toDomain(), const TimeDuration.seconds(60.0));
          });

          test('maps LengthDto to Length', () {
            final dto = LengthDto(meters: 1000.0);
            expect(dto.toDomain(), const Length.meters(1000.0));
          });

          test('maps TemperatureDto to Temperature', () {
            final dto = TemperatureDto(celsius: 37.0);
            expect(dto.toDomain(), const Temperature.celsius(37.0));
          });

          test('maps PressureDto to Pressure', () {
            final dto = PressureDto(millimetersOfMercury: 120.0);
            expect(dto.toDomain(), const Pressure.millimetersOfMercury(120.0));
          });

          test('maps VelocityDto to Velocity', () {
            final dto = VelocityDto(metersPerSecond: 10.0);
            expect(dto.toDomain(), const Velocity.metersPerSecond(10.0));
          });

          test('maps VolumeDto to Volume', () {
            final dto = VolumeDto(liters: 2.0);
            expect(dto.toDomain(), const Volume.liters(2.0));
          });

          test('maps PowerDto to Power', () {
            final dto = PowerDto(watts: 100.0);
            expect(dto.toDomain(), const Power.watts(100.0));
          });

          test('maps BloodGlucoseDto to BloodGlucose', () {
            final dto = BloodGlucoseDto(millimolesPerLiter: 5.5);
            expect(dto.toDomain(), const BloodGlucose.millimolesPerLiter(5.5));
          });

          test('maps NumberDto to Number', () {
            final dto = NumberDto(value: 42.0);
            expect(dto.toDomain(), const Number(42.0));
          });

          test('maps PercentageDto to Percentage', () {
            final dto = PercentageDto(decimal: 0.95);
            expect(dto.toDomain(), const Percentage.fromDecimal(0.95));
          });
        },
      );

      group(
        'MeasurementUnitToDto',
        () {
          test('converts Mass to MassDto', () {
            const domain = Mass.kilograms(70.0);
            final dto = domain.toDto();
            expect(dto.kilograms, 70.0);
          });

          test('converts Energy to EnergyDto', () {
            const domain = Energy.kilocalories(2000.0);
            final dto = domain.toDto();
            expect(dto.kilocalories, 2000.0);
          });

          test('converts TimeDuration to TimeDurationDto', () {
            const domain = TimeDuration.seconds(60.0);
            final dto = domain.toDto();
            expect(dto.seconds, 60.0);
          });

          test('converts Length to LengthDto', () {
            const domain = Length.meters(1000.0);
            final dto = domain.toDto();
            expect(dto.meters, 1000.0);
          });

          test('converts Temperature to TemperatureDto', () {
            const domain = Temperature.celsius(37.0);
            final dto = domain.toDto();
            expect(dto.celsius, 37.0);
          });

          test('converts Pressure to PressureDto', () {
            const domain = Pressure.millimetersOfMercury(120.0);
            final dto = domain.toDto();
            expect(dto.millimetersOfMercury, 120.0);
          });

          test('converts Velocity to VelocityDto', () {
            const domain = Velocity.metersPerSecond(10.0);
            final dto = domain.toDto();
            expect(dto.metersPerSecond, 10.0);
          });

          test('converts Volume to VolumeDto', () {
            const domain = Volume.liters(2.0);
            final dto = domain.toDto();
            expect(dto.liters, 2.0);
          });

          test('converts Power to PowerDto', () {
            const domain = Power.watts(100.0);
            final dto = domain.toDto();
            expect(dto.watts, 100.0);
          });

          test('converts BloodGlucose to BloodGlucoseDto', () {
            const domain = BloodGlucose.millimolesPerLiter(5.5);
            final dto = domain.toDto();
            expect(dto.millimolesPerLiter, 5.5);
          });

          test('converts Number to NumberDto', () {
            const domain = Number(42.0);
            final dto = domain.toDto();
            expect(dto.value, 42.0);
          });

          test('converts Percentage to PercentageDto', () {
            const domain = Percentage.fromDecimal(0.95);
            final dto = domain.toDto();
            expect(dto.decimal, 0.95);
          });
        },
      );
    },
  );
}
