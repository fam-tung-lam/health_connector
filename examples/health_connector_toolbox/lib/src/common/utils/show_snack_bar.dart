import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';

/// Enum representing different types of snack bars.
enum SnackBarType {
  /// Informational message
  info,

  /// Warning message
  warning,

  /// Error message
  error,

  /// Success message
  success,
}

/// Shows a snack bar with the specified type and message.
///
/// [context] - The BuildContext to show the snack bar in.
/// [type] - The type of snack bar (info, warning, error, success).
/// [message] - The message to display.
/// [duration] - Optional duration for the snack bar. Defaults to 4 seconds.
/// [action] - Optional action button for the snack bar.
void showAppSnackBar(
  BuildContext context,
  SnackBarType type,
  String message, {
  Duration? duration,
  SnackBarAction? action,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: _getBackgroundColor(type),
    behavior: SnackBarBehavior.floating,
    duration: duration ?? const Duration(seconds: 4),
    showCloseIcon: true,
    action: action,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Returns the background color for the given snack bar type.
Color _getBackgroundColor(SnackBarType type) {
  return switch (type) {
    SnackBarType.info => AppColors.infoDark,
    SnackBarType.warning => AppColors.warning,
    SnackBarType.error => AppColors.errorDark,
    SnackBarType.success => AppColors.successDark,
  };
}
