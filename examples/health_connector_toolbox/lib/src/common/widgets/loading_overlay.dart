import 'package:flutter/material.dart';

import 'package:health_connector_toolbox/src/common/widgets/loading_indicator.dart';

/// A widget that displays a gray transparent overlay with a loading indicator
/// in the center. Typically used during button operations like form submission
/// to prevent user interaction while an operation is in progress.
@immutable
final class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.isLoading,
    required this.child,
    super.key,
  });

  /// Whether the overlay should be displayed.
  final bool isLoading;

  /// The child widget to display behind the overlay.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isLoading,
      child: Stack(
        children: [
          child,
          if (isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                child: ColoredBox(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  child: const LoadingIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
