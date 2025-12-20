import 'package:flutter/material.dart' hide Interval, Velocity;
import 'package:health_connector/health_connector.dart'
    show
        BloodGlucose,
        Energy,
        TimeDuration,
        Length,
        Mass,
        MeasurementUnit,
        Numeric,
        Percentage,
        Power,
        Pressure,
        RespiratoryRate,
        Temperature,
        Vo2Max,
        Velocity,
        Volume;
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';

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
    return switch (unit) {
      Mass(
        :final inKilograms,
        :final inGrams,
        :final inPounds,
        :final inOunces,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inKilograms.toStringAsFixed(2)} kg',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inGrams.toStringAsFixed(2)} g',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inPounds.toStringAsFixed(2)} lbs',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inOunces.toStringAsFixed(2)} oz',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Length(
        :final inMeters,
        :final inKilometers,
        :final inCentimeters,
        :final inMillimeters,
        :final inMiles,
        :final inFeet,
        :final inInches,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inMeters.toStringAsFixed(2)} m',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inKilometers.toStringAsFixed(4)} km',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inCentimeters.toStringAsFixed(2)} cm',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inMillimeters.toStringAsFixed(2)} mm',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inMiles.toStringAsFixed(4)} mi',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inFeet.toStringAsFixed(2)} ft',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inInches.toStringAsFixed(2)} in',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Energy(
        :final inKilocalories,
        :final inCalories,
        :final inKilojoules,
        :final inJoules,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inKilocalories.toStringAsFixed(2)} kcal',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inCalories.toStringAsFixed(2)} cal',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inKilojoules.toStringAsFixed(2)} kJ',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inJoules.toStringAsFixed(2)} J',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Volume(
        :final inLiters,
        :final inMilliliters,
        :final inFluidOuncesUs,
        :final inFluidOuncesImp,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inLiters.toStringAsFixed(2)} L',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inMilliliters.toStringAsFixed(2)} mL',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inFluidOuncesUs.toStringAsFixed(2)} fl oz (US)',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inFluidOuncesImp.toStringAsFixed(2)} fl oz (Imp)',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Temperature(:final inCelsius, :final inFahrenheit, :final inKelvin) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inCelsius.toStringAsFixed(2)} °C',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inFahrenheit.toStringAsFixed(2)} °F',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inKelvin.toStringAsFixed(2)} K',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Pressure(:final inMillimetersOfMercury, :final inPascals) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${inMillimetersOfMercury.toStringAsFixed(1)} mmHg',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${inPascals.toStringAsFixed(1)} Pa',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
          ),
        ],
      ),
      BloodGlucose(
        :final inMillimolesPerLiter,
        :final inMilligramsPerDeciliter,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inMillimolesPerLiter.toStringAsFixed(2)} mmol/L',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inMilligramsPerDeciliter.toStringAsFixed(2)} mg/dL',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Power(:final inWatts, :final inKilowatts) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${inWatts.toStringAsFixed(1)} W',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${inKilowatts.toStringAsFixed(4)} kW',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
          ),
        ],
      ),
      Velocity(
        :final inMetersPerSecond,
        :final inKilometersPerHour,
        :final inMilesPerHour,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inMetersPerSecond.toStringAsFixed(2)} m/s',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inKilometersPerHour.toStringAsFixed(2)} km/h',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            const SizedBox(height: 4),
            Text(
              '${inMilesPerHour.toStringAsFixed(2)} mph',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Numeric(:final value) => Text(
        value.toStringAsFixed(2),
        style:
            Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
      TimeDuration(:final inSeconds, :final inMinutes, :final inHours) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${inHours.toStringAsFixed(2)} hours',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${inMinutes.toStringAsFixed(2)} minutes',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
            Text(
              '${inSeconds.toStringAsFixed(0)} seconds',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      Percentage(:final asWhole, :final asDecimal) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${asWhole.toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${asDecimal.toStringAsFixed(4)} (decimal)',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
          ),
        ],
      ),
      RespiratoryRate(:final breathsPerMinute) => Text(
        '${breathsPerMinute.toStringAsFixed(0)} breaths/min',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      Vo2Max(:final value) => Text(
        '${value.toStringAsFixed(2)} mL/kg/min',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    };
  }
}
