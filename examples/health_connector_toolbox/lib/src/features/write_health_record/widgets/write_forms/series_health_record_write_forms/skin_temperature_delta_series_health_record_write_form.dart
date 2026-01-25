import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/skin_temperature_delta_sample_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_form.dart';

/// Form widget for skin temperature delta series records.
@immutable
final class SkinTemperatureDeltaSeriesWriteForm
    extends SeriesHealthRecordWriteForm<SkinTemperatureDeltaSample> {
  const SkinTemperatureDeltaSeriesWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SkinTemperatureDeltaSeriesFormState createState() =>
      SkinTemperatureDeltaSeriesFormState();
}

/// State for skin temperature delta series form widget.
final class SkinTemperatureDeltaSeriesFormState
    extends
        SeriesHealthRecordFormState<
          SkinTemperatureDeltaSample,
          SkinTemperatureDeltaSeriesWriteForm
        > {
  Temperature? _baseline;
  SkinTemperatureMeasurementLocation _measurementLocation =
      SkinTemperatureMeasurementLocation.unknown;

  @override
  List<Widget> buildSeriesFields(BuildContext context) {
    return [
      // Baseline temperature field
      TextFormField(
        initialValue: _baseline?.inCelsius.toStringAsFixed(1),
        decoration: const InputDecoration(
          labelText: 'Baseline Temperature (°C)',
          helperText: 'Optional. Range: 0.0 to 100.0°C',
          border: OutlineInputBorder(),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) {
          final parsed = double.tryParse(value);
          if (parsed != null && parsed >= 0.0 && parsed <= 100.0) {
            setState(() {
              _baseline = Temperature.celsius(parsed);
            });
          } else if (value.isEmpty) {
            setState(() {
              _baseline = null;
            });
          }
        },
      ),
      const SizedBox(height: 16),

      // Measurement location dropdown
      DropdownButtonFormField<SkinTemperatureMeasurementLocation>(
        initialValue: _measurementLocation,
        decoration: const InputDecoration(
          labelText: 'Measurement Location',
          border: OutlineInputBorder(),
        ),
        items: SkinTemperatureMeasurementLocation.values.map((location) {
          return DropdownMenuItem<SkinTemperatureMeasurementLocation>(
            value: location,
            child: Text(location.name),
          );
        }).toList(),
        onChanged: (location) {
          if (location != null) {
            setState(() {
              _measurementLocation = location;
            });
          }
        },
      ),
      const SizedBox(height: 16),

      // Samples field
      SkinTemperatureDeltaSampleWriteFormFieldGroup(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        onChanged: (newSamples) {
          setState(() {
            samples = newSamples ?? [];
          });
        },
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return SkinTemperatureDeltaSeriesRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      samples: samples,
      baseline: _baseline,
      measurementLocation: _measurementLocation,
      metadata: metadata,
    );
  }
}
