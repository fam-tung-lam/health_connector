import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';

/// Mixin that provides reusable error handling for health connector operations.
///
/// This mixin extracts the repetitive error handling pattern used across
/// multiple methods in the read health records feature. It handles both
/// [HealthConnectorException] and generic exceptions with appropriate
/// user feedback via SnackBar.
///
/// Usage:
/// ```dart
/// class MyState extends State<MyWidget> with
/// ProcessOperationWithErrorHandlerPageStateMixin {
///   Future<void> someOperation() async {
///     await process(
///       () => healthConnector.someMethod(),
///     );
///   }
/// }
/// ```
mixin ProcessOperationWithErrorHandlerPageStateMixin<T extends StatefulWidget>
    on State<T> {
  /// Executes a health operation with consistent error handling.
  ///
  /// Wraps the [operation] in try-catch blocks that handle:
  /// - [HealthConnectorException]: Shows specific error messages, with
  ///   special handling for [HealthConnectorErrorCode.unsupportedOperation]
  /// - Generic [Exception]: Shows generic error message with exception details
  ///
  /// The method respects widget lifecycle by checking [mounted] before
  /// showing error messages, preventing errors after widget disposal.
  ///
  /// ## Parameters
  ///
  /// - [operation]: The async operation to execute
  ///
  /// ## Example
  ///
  /// ```dart
  /// await process(
  ///   () => notifier.readHealthRecords(request),
  /// );
  /// ```
  Future<void> process(Future<void> Function() operation) async {
    try {
      await operation();
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(context, SnackBarType.error, e.message);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.error,
        '${AppTexts.errorPrefixColon} $e',
      );
    }
  }
}
