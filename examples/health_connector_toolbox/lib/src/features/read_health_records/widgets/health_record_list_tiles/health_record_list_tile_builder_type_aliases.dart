import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthRecord;

/// Builder function type for creating a title string from a health record.
typedef RecordTitleBuilder<T extends HealthRecord> = String Function(T record);

/// Builder function type for creating an icon from a health record.
typedef RecordIconBuilder<T extends HealthRecord> = IconData Function(T record);

/// Builder function type for creating a subtitle widget from a health record.
typedef RecordSubtitleBuilder<T extends HealthRecord> =
    Widget Function(
      T record,
      BuildContext context,
    );

/// Builder function type for creating detail row widgets from a health record.
typedef RecordDetailRowsBuilder<T extends HealthRecord> =
    List<Widget> Function(
      T record,
      BuildContext context,
    );

/// Builder function type for creating sample display widgets from a
/// series record.
typedef SeriesSamplesBuilder<T> =
    Widget? Function(
      T samples,
      BuildContext context,
    );
