import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_theme_data.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/home/home_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/home/pages/home_page.dart';
import 'package:provider/provider.dart';

/// The root widget of the Health Connector Toolbox application.
///
/// This widget provides the app-wide [ConsoleLogStore], initializes the
/// Health Connector and provides it to the widget tree via a
/// ChangeNotifierProvider, then displays the home page.
@immutable
final class HealthConnectorToolboxApp extends StatelessWidget {
  const HealthConnectorToolboxApp({
    required this.consoleLogStore,
    super.key,
  });

  /// Central store receiving every SDK log event captured by the app.
  final ConsoleLogStore consoleLogStore;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ChangeNotifierProvider<ConsoleLogStore>.value(
        value: consoleLogStore,
        child: ChangeNotifierProvider(
          create: (_) =>
              HomeChangeNotifier(consoleLogStore: consoleLogStore)..init(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppTexts.healthConnectorToolbox,
            theme: appThemeData,
            home: const HomePage(),
          ),
        ),
      ),
    );
  }
}
