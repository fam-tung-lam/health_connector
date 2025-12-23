import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HealthConnector, HealthPlatform, PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/error_view.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_indicator.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/permissions/permissions_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/permissions_content_view.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, Provider, Selector;

/// Page for managing health data permissions.
///
/// Dynamically displays all available data type permissions (read/write for
/// all health data types) and feature permissions (all platform features).
/// Allows users to select and request multiple permissions at once.
@immutable
final class PermissionsPage extends StatefulWidget {
  const PermissionsPage({required this.healthPlatform, super.key});

  final HealthPlatform healthPlatform;

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage>
    with ProcessOperationWithErrorHandlerPageStateMixin<PermissionsPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PermissionsChangeNotifier(
        Provider.of<HealthConnector>(context),
      ),
      child:
          Selector<
            PermissionsChangeNotifier,
            ({bool isPageLoading, bool isRequestLoading})
          >(
            selector: (_, notifier) => (
              isPageLoading: notifier.isPageLoading,
              isRequestLoading: notifier.loadingState is LoadingRequest,
            ),
            builder: (context, loadingState, _) {
              final notifier = Provider.of<PermissionsChangeNotifier>(context);
              return LoadingOverlay(
                isLoading: loadingState.isRequestLoading,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(AppTexts.requestPermissions),
                  ),
                  body: loadingState.isPageLoading
                      ? const LoadingIndicator()
                      : notifier.errorMessage != null
                      ? ErrorView(
                          message:
                              notifier.errorMessage ??
                              AppTexts.failedToLoadFeatureStatuses,
                          onRetry: notifier.loadFeatureStatuses,
                        )
                      : PermissionsContentView(
                          notifier: notifier,
                          searchQuery: _searchQuery,
                          onSearchChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          onRequestPermissions: () =>
                              _requestPermissions(context, notifier),
                        ),
                ),
              );
            },
          ),
    );
  }

  Future<void> _requestPermissions(
    BuildContext context,
    PermissionsChangeNotifier notifier,
  ) async {
    if (notifier.selectedPermissions.isEmpty) {
      showAppSnackBar(
        context,
        SnackBarType.warning,
        AppTexts.pleaseSelectAtLeastOnePermission,
      );
      return;
    }

    await process(() async {
      await notifier.requestPermissions(notifier.selectedPermissions.toList());

      if (!mounted) {
        return;
      }

      final grantedCount = notifier.permissionResults.values
          .where((status) => status == PermissionStatus.granted)
          .length;
      final deniedCount = notifier.permissionResults.values
          .where((status) => status == PermissionStatus.denied)
          .length;

      showAppSnackBar(
        context,
        grantedCount > 0 ? SnackBarType.success : SnackBarType.warning,
        '${AppTexts.requestCompleted} $grantedCount '
        '${AppTexts.granted}, $deniedCount ${AppTexts.denied}',
      );
    });
  }
}
