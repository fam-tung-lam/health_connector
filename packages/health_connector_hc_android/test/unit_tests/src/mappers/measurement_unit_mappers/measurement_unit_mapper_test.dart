import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'MeasurementUnitMapper',
    () {
      group(
        'MeasurementUnitDtoToDomain',
        () {
          parameterizedTest(
            'converts MeasurementUnitDto to MeasurementUnit for all types',
            [
              [
                MassDto(value: 70.0, unit: MassUnitDto.kilograms),
                const Mass.kilograms(70.0),
              ],
              [
                EnergyDto(value: 2000.0, unit: EnergyUnitDto.kilocalories),
                const Energy.kilocalories(2000.0),
              ],
              [
                TimeDurationDto(value: 60.0, unit: TimeDurationUnitDto.seconds),
                const TimeDuration.seconds(60.0),
              ],
              [
                LengthDto(value: 1000.0, unit: LengthUnitDto.meters),
                const Length.meters(1000.0),
              ],
              [
                TemperatureDto(value: 37.0, unit: TemperatureUnitDto.celsius),
                const Temperature.celsius(37.0),
              ],
              [
                PressureDto(
                  value: 120.0,
                  unit: PressureUnitDto.millimetersOfMercury,
                ),
                const Pressure.millimetersOfMercury(120.0),
              ],
              [
                VelocityDto(
                  value: 10.0,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
                const Velocity.metersPerSecond(10.0),
              ],
              [
                VolumeDto(value: 2.0, unit: VolumeUnitDto.liters),
                const Volume.liters(2.0),
              ],
              [
                PowerDto(value: 100.0, unit: PowerUnitDto.watts),
                const Power.watts(100.0),
              ],
              [
                BloodGlucoseDto(
                  value: 5.5,
                  unit: BloodGlucoseUnitDto.millimolesPerLiter,
                ),
                const BloodGlucose.millimolesPerLiter(5.5),
              ],
              [
                NumberDto(value: 42.0),
                const Number(42.0),
              ],
              [
                PercentageDto(value: 0.95, unit: PercentageUnitDto.decimal),
                const Percentage.fromDecimal(0.95),
              ],
            ],
            (MeasurementUnitDto dto, MeasurementUnit expectedDomain) {
              final domain = dto.toDomain();

              // Verify that the conversion produces the expected domain object
              expect(domain.runtimeType, expectedDomain.runtimeType);

              // Type-specific assertions to verify values
              switch (domain) {
                case Mass():
                  expect(
                    domain.inKilograms,
                    (expectedDomain as Mass).inKilograms,
                  );
                case Energy():
                  expect(
                    domain.inKilocalories,
                    (expectedDomain as Energy).inKilocalories,
                  );
                case TimeDuration():
                  expect(
                    domain.inSeconds,
                    (expectedDomain as TimeDuration).inSeconds,
                  );
                case Length():
                  expect(
                    domain.inMeters,
                    (expectedDomain as Length).inMeters,
                  );
                case Temperature():
                  expect(
                    domain.inCelsius,
                    (expectedDomain as Temperature).inCelsius,
                  );
                case Pressure():
                  expect(
                    domain.inMillimetersOfMercury,
                    (expectedDomain as Pressure).inMillimetersOfMercury,
                  );
                case Velocity():
                  expect(
                    domain.inMetersPerSecond,
                    (expectedDomain as Velocity).inMetersPerSecond,
                  );
                case Volume():
                  expect(
                    domain.inLiters,
                    (expectedDomain as Volume).inLiters,
                  );
                case Power():
                  expect(
                    domain.inWatts,
                    (expectedDomain as Power).inWatts,
                  );
                case BloodGlucose():
                  expect(
                    domain.inMillimolesPerLiter,
                    (expectedDomain as BloodGlucose).inMillimolesPerLiter,
                  );
                case Number():
                  expect(
                    domain.value,
                    (expectedDomain as Number).value,
                  );
                case Percentage():
                  expect(
                    domain.asDecimal,
                    (expectedDomain as Percentage).asDecimal,
                  );
              }
            },
          );
        },
      );

      group(
        'MeasurementUnitToDto',
        () {
          parameterizedTest(
            'converts MeasurementUnit to MeasurementUnitDto for all types',
            [
              [
                const Mass.kilograms(70.0),
                MassDto(value: 70.0, unit: MassUnitDto.kilograms),
              ],
              [
                const Energy.kilocalories(2000.0),
                EnergyDto(value: 2000.0, unit: EnergyUnitDto.kilocalories),
              ],
              [
                const TimeDuration.seconds(60.0),
                TimeDurationDto(value: 60.0, unit: TimeDurationUnitDto.seconds),
              ],
              [
                const Length.meters(1000.0),
                LengthDto(value: 1000.0, unit: LengthUnitDto.meters),
              ],
              [
                const Temperature.celsius(37.0),
                TemperatureDto(value: 37.0, unit: TemperatureUnitDto.celsius),
              ],
              [
                const Pressure.millimetersOfMercury(120.0),
                PressureDto(
                  value: 120.0,
                  unit: PressureUnitDto.millimetersOfMercury,
                ),
              ],
              [
                const Velocity.metersPerSecond(10.0),
                VelocityDto(
                  value: 10.0,
                  unit: VelocityUnitDto.metersPerSecond,
                ),
              ],
              [
                const Volume.liters(2.0),
                VolumeDto(value: 2.0, unit: VolumeUnitDto.liters),
              ],
              [
                const Power.watts(100.0),
                PowerDto(value: 100.0, unit: PowerUnitDto.watts),
              ],
              [
                const BloodGlucose.millimolesPerLiter(5.5),
                BloodGlucoseDto(
                  value: 5.5,
                  unit: BloodGlucoseUnitDto.millimolesPerLiter,
                ),
              ],
              [
                const Number(42.0),
                NumberDto(value: 42.0),
              ],
              [
                const Percentage.fromDecimal(0.95),
                PercentageDto(value: 0.95, unit: PercentageUnitDto.decimal),
              ],
            ],
            (MeasurementUnit domain, MeasurementUnitDto expectedDto) {
              final dto = domain.toDto();

              // Verify that the conversion produces the expected DTO type
              expect(dto.runtimeType, expectedDto.runtimeType);

              // Type-specific assertions to verify values
              switch (dto) {
                case MassDto():
                  expect(dto.value, (expectedDto as MassDto).value);
                  expect(dto.unit, expectedDto.unit);
                case EnergyDto():
                  expect(dto.value, (expectedDto as EnergyDto).value);
                  expect(dto.unit, expectedDto.unit);
                case TimeDurationDto():
                  expect(dto.value, (expectedDto as TimeDurationDto).value);
                  expect(dto.unit, expectedDto.unit);
                case LengthDto():
                  expect(dto.value, (expectedDto as LengthDto).value);
                  expect(dto.unit, expectedDto.unit);
                case TemperatureDto():
                  expect(dto.value, (expectedDto as TemperatureDto).value);
                  expect(dto.unit, expectedDto.unit);
                case PressureDto():
                  expect(dto.value, (expectedDto as PressureDto).value);
                  expect(dto.unit, expectedDto.unit);
                case VelocityDto():
                  expect(dto.value, (expectedDto as VelocityDto).value);
                  expect(dto.unit, expectedDto.unit);
                case VolumeDto():
                  expect(dto.value, (expectedDto as VolumeDto).value);
                  expect(dto.unit, expectedDto.unit);
                case PowerDto():
                  expect(dto.value, (expectedDto as PowerDto).value);
                  expect(dto.unit, expectedDto.unit);
                case BloodGlucoseDto():
                  expect(dto.value, (expectedDto as BloodGlucoseDto).value);
                  expect(dto.unit, expectedDto.unit);
                case NumberDto():
                  expect(dto.value, (expectedDto as NumberDto).value);
                case PercentageDto():
                  expect(dto.value, (expectedDto as PercentageDto).value);
                  expect(dto.unit, expectedDto.unit);
              }
            },
          );
        },
      );
    },
  );
}
