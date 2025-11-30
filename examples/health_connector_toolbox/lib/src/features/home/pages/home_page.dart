import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/aggregate_health_data_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/pages/aggregate_health_data_page.dart';
import 'package:health_connector_toolbox/src/features/home/home_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/permissions/pages/permissions_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/pages/read_health_records_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/pages/write_health_record_page.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart'
    show Consumer, Provider, ChangeNotifierProvider;

/// The main home page of the application.
///
/// Displays navigation buttons to access different features of the Health
/// Connector Toolbox: permissions, read records, write records,
/// and aggregation.
@immutable
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<HomeChangeNotifier>(
          builder: (context, notifier, _) {
            if (notifier.isLoading) {
              return const CircularProgressIndicator();
            }

            if (notifier.error != null) {
              return Text(notifier.error.toString());
            }

            final healthConnector = notifier.healthConnector;
            if (healthConnector == null) {
              return const CircularProgressIndicator();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    healthConnector.healthPlatform.displayName,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Provider<HealthConnector>.value(
                              value: healthConnector,
                              child: PermissionsPage(
                                healthPlatform: healthConnector.healthPlatform,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(AppTexts.permissions.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => ReadHealthRecordsChangeNotifier(
                                healthConnector,
                              ),
                              child: ReadHealthRecordsPage(
                                healthPlatform: healthConnector.healthPlatform,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(AppTexts.readHealthRecords.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Provider<HealthConnector>.value(
                              value: healthConnector,
                              child: ChangeNotifierProvider(
                                create: (_) => WriteHealthRecordChangeNotifier(
                                  healthConnector,
                                ),
                                child: WriteHealthRecordPage(
                                  healthPlatform:
                                      healthConnector.healthPlatform,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(AppTexts.writeRecords.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => AggregateHealthDataChangeNotifier(
                                healthConnector,
                              ),
                              child: AggregateHealthDataPage(
                                healthPlatform: healthConnector.healthPlatform,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(AppTexts.aggregate.toUpperCase()),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
