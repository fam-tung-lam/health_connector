import 'package:flutter/material.dart' hide Interval, Velocity;
import 'package:health_connector/health_connector_internal.dart'
    show
        BloodGlucose,
        Energy,
        Frequency,
        TimeDuration,
        Length,
        Mass,
        MeasurementUnit,
        Number,
        Percentage,
        Power,
        Pressure,
        Temperature,
        Velocity,
        Volume;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A reusable widget for displaying measurement units with all available
/// unit conversions.
///
/// Displays the primary unit in bold with primary color, and all secondary
/// units in grey below it.
@immutable
final class MeasurementUnitDisplay extends StatelessWidget {
  const MeasurementUnitDisplay({
    required this.unit,
    super.key,
  });

  /// The measurement unit to display.
  final MeasurementUnit unit;

  @override
  Widget build(BuildContext context) {
    switch (unit) {
      case Mass(
        :final inKilograms,
        :final inGrams,
        :final inPounds,
        :final inOunces,
      ):
        return _UnitDisplay(
          primaryValue:
              '${inKilograms.toStringAsFixed(2)} ${AppTexts.kilogram}',
          secondaryValues: [
            '${inGrams.toStringAsFixed(2)} ${AppTexts.gram}',
            '${inPounds.toStringAsFixed(2)} ${AppTexts.pound}',
            '${inOunces.toStringAsFixed(2)} ${AppTexts.ounce}',
          ],
        );
      case Length(
        :final inMeters,
        :final inKilometers,
        :final inCentimeters,
        :final inMillimeters,
        :final inMiles,
        :final inFeet,
        :final inInches,
      ):
        return _UnitDisplay(
          primaryValue: '${inMeters.toStringAsFixed(2)} ${AppTexts.meter}',
          secondaryValues: [
            '${inKilometers.toStringAsFixed(4)} ${AppTexts.kilometer}',
            '${inCentimeters.toStringAsFixed(2)} ${AppTexts.centimeter}',
            '${inMillimeters.toStringAsFixed(2)} ${AppTexts.millimeter}',
            '${inMiles.toStringAsFixed(4)} ${AppTexts.mile}',
            '${inFeet.toStringAsFixed(2)} ${AppTexts.foot}',
            '${inInches.toStringAsFixed(2)} ${AppTexts.inch}',
          ],
        );
      case Energy(
        :final inKilocalories,
        :final inCalories,
        :final inKilojoules,
        :final inJoules,
      ):
        return _UnitDisplay(
          primaryValue:
              '${inKilocalories.toStringAsFixed(2)} ${AppTexts.kilocalories}',
          secondaryValues: [
            '${inCalories.toStringAsFixed(2)} ${AppTexts.calories}',
            '${inKilojoules.toStringAsFixed(2)} ${AppTexts.kilojoule}',
            '${inJoules.toStringAsFixed(2)} ${AppTexts.joule}',
          ],
        );
      case Volume(
        :final inLiters,
        :final inMilliliters,
        :final inFluidOuncesUs,
        :final inFluidOuncesImp,
      ):
        return _UnitDisplay(
          primaryValue: '${inLiters.toStringAsFixed(2)} ${AppTexts.liter}',
          secondaryValues: [
            '${inMilliliters.toStringAsFixed(2)} ${AppTexts.milliliter}',
            '${inFluidOuncesUs.toStringAsFixed(2)} ${AppTexts.fluidOunceUS}',
            '${inFluidOuncesImp.toStringAsFixed(2)} ${AppTexts.fluidOunceImp}',
          ],
        );
      case Temperature(:final inCelsius, :final inFahrenheit, :final inKelvin):
        return _UnitDisplay(
          primaryValue: '${inCelsius.toStringAsFixed(2)} ${AppTexts.celsius}',
          secondaryValues: [
            '${inFahrenheit.toStringAsFixed(2)} ${AppTexts.fahrenheit}',
            '${inKelvin.toStringAsFixed(2)} ${AppTexts.kelvin}',
          ],
        );
      case Pressure(:final inMillimetersOfMercury, :final inPascals):
        return _UnitDisplay(
          primaryValue:
              '${inMillimetersOfMercury.toStringAsFixed(1)} '
              '${AppTexts.millimetersOfMercury}',
          secondaryValues: [
            '${inPascals.toStringAsFixed(1)} ${AppTexts.pascal}',
          ],
        );
      case BloodGlucose(
        :final inMillimolesPerLiter,
        :final inMilligramsPerDeciliter,
      ):
        final milligramsText =
            '${inMilligramsPerDeciliter.toStringAsFixed(2)} '
            '${AppTexts.milligramsPerDeciliter}';
        return _UnitDisplay(
          primaryValue:
              '${inMillimolesPerLiter.toStringAsFixed(2)} '
              '${AppTexts.millimolesPerLiter}',
          secondaryValues: [
            milligramsText,
          ],
        );
      case Power(:final inWatts, :final inKilowatts):
        return _UnitDisplay(
          primaryValue: '${inWatts.toStringAsFixed(1)} ${AppTexts.watt}',
          secondaryValues: [
            '${inKilowatts.toStringAsFixed(4)} ${AppTexts.kilowatt}',
          ],
        );
      case Velocity(
        :final inMetersPerSecond,
        :final inKilometersPerHour,
        :final inMilesPerHour,
      ):
        final kilometersText =
            '${inKilometersPerHour.toStringAsFixed(2)} '
            '${AppTexts.kilometersPerHour}';
        return _UnitDisplay(
          primaryValue:
              '${inMetersPerSecond.toStringAsFixed(2)} '
              '${AppTexts.metersPerSecond}',
          secondaryValues: [
            kilometersText,
            '${inMilesPerHour.toStringAsFixed(2)} ${AppTexts.milesPerHour}',
          ],
        );
      case Number(value: final count):
        return Text(
          count.toStringAsFixed(0),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        );
      case TimeDuration(:final inSeconds, :final inMinutes, :final inHours):
        return _UnitDisplay(
          primaryValue: '${inHours.toStringAsFixed(2)} ${AppTexts.hours}',
          secondaryValues: [
            '${inMinutes.toStringAsFixed(2)} ${AppTexts.minutes}',
            '${inSeconds.toStringAsFixed(0)} ${AppTexts.secondsFull}',
          ],
        );
      case Percentage(:final asWhole, :final asDecimal):
        return _UnitDisplay(
          primaryValue: '${asWhole.toStringAsFixed(2)}${AppTexts.percent}',
          secondaryValues: [
            '${asDecimal.toStringAsFixed(4)} ${AppTexts.decimal}',
          ],
        );
      case Frequency(:final inPerMinute, :final inPerSecond):
        return _UnitDisplay(
          primaryValue:
              '${inPerMinute.toStringAsFixed(1)} ${AppTexts.perMinute}',
          secondaryValues: [
            '${inPerSecond.toStringAsFixed(3)} ${AppTexts.perSecond}',
          ],
        );
    }
  }
}

/// Helper widget for displaying a measurement unit with primary and
/// secondary values.
///
/// Displays the primary value in bold with primary color, and secondary values
/// in grey text below it with consistent spacing.
class _UnitDisplay extends StatelessWidget {
  const _UnitDisplay({
    required this.primaryValue,
    required this.secondaryValues,
  });

  /// Primary measurement value to display (e.g., "5.00 kg").
  final String primaryValue;

  /// List of secondary values to display below the primary value.
  final List<String> secondaryValues;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary value
        Text(
          primaryValue,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        // Secondary values
        ...secondaryValues.expand(
          (value) => [
            const SizedBox(height: 4.0),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
