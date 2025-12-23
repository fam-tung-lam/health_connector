import 'package:flutter/material.dart';

/// Shows a confirmation dialog for destructive actions.
///
/// Returns true if the user confirms, false if they cancel.
Future<bool> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),

          child: Text(confirmText),
        ),
      ],
    ),
  );

  return result ?? false;
}
