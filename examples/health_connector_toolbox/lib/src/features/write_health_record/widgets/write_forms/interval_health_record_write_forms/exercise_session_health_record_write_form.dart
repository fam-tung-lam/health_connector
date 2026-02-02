import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/exercise_route_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/exercise_session_event_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for exercise session records.
@immutable
final class ExerciseSessionWriteForm extends IntervalHealthRecordWriteForm {
  const ExerciseSessionWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ExerciseSessionFormState createState() => ExerciseSessionFormState();
}

/// State for exercise session form widget.
final class ExerciseSessionFormState
    extends IntervalHealthRecordFormState<ExerciseSessionWriteForm> {
  /// The type of exercise performed (required).
  ExerciseType? exerciseType;

  /// Optional title for the exercise session.
  String? title;

  /// Optional notes for the exercise session.
  String? notes;

  /// List of events within this exercise session.
  List<ExerciseSessionEvent> events = [];

  /// List of route locations for the GPS route.
  List<ExerciseRouteLocation>? routeLocations;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<ExerciseType>(
        labelText: AppTexts.exerciseType,
        values: ExerciseType.values
            .where((type) => type.isSupportedOnPlatform(widget.healthPlatform))
            .toList(),
        initialValue: exerciseType,
        onChanged: (type) => setState(() => exerciseType = type),
        validator: (type) => type == null
            ? AppTexts.getPleaseSelectText(AppTexts.exerciseType)
            : null,
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.fitnessCenter,
        hint: AppTexts.pleaseSelect,
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.exerciseTitleOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.exerciseTitleHelper,
        ),
        onChanged: (value) => setState(() {
          title = value.isEmpty ? null : value;
        }),
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.exerciseNotesOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.exerciseNotesHelper,
        ),
        onChanged: (value) => setState(() {
          notes = value.isEmpty ? null : value;
        }),
        maxLines: 3,
      ),
      const SizedBox(height: 16),
      ExerciseSessionEventFormFieldGroup(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        healthPlatform: widget.healthPlatform,
        initialEvents: events.isEmpty ? null : events,
        onChanged: (newEvents) {
          setState(() {
            events = newEvents ?? [];
          });
        },
      ),
      const SizedBox(height: 16),
      ExerciseRouteFormFieldGroup(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        initialLocations: routeLocations,
        onChanged: (locations) => setState(() => routeLocations = locations),
      ),
    ];
  }

  @override
  bool validate() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    return exerciseType != null;
  }

  @override
  HealthRecord buildRecord() {
    return ExerciseSessionRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      exerciseType: exerciseType!,
      metadata: metadata,
      title: title,
      notes: notes,
      events: events,
      exerciseRoute: routeLocations != null && routeLocations!.isNotEmpty
          ? ExerciseRoute(routeLocations!)
          : null,
    );
  }
}
