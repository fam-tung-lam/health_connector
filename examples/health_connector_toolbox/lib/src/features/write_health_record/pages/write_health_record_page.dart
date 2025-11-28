import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/pages/write_health_record_form_page.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/data_type_card.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart';

/// Landing page for writing health records.
///
/// Displays a list of available health data types (steps, weight, etc.) as
/// cards. Tapping a card navigates to a type-specific write page.
@immutable
final class WriteHealthRecordPage extends StatelessWidget {
  const WriteHealthRecordPage({required this.healthPlatform, super.key});

  final HealthPlatform healthPlatform;

  @override
  Widget build(BuildContext context) {
    final supportedHealthDataTypes = HealthDataType.values
        .where(
          (type) => type.supportedHealthPlatforms.contains(healthPlatform),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.insertHealthRecord)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: supportedHealthDataTypes.length,
        itemBuilder: (_, int index) {
          final type = supportedHealthDataTypes[index];

          return DataTypeCard(
            title: type.displayName,
            description: type.description,
            icon: type.icon,
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) =>
                      ChangeNotifierProvider<
                        WriteHealthRecordChangeNotifier
                      >.value(
                        value: context.read<WriteHealthRecordChangeNotifier>(),
                        child: WriteHealthRecordFormPage(dataType: type),
                      ),
                ),
              );
            },
          );
        },
        separatorBuilder: (_, int index) => const SizedBox(height: 10),
      ),
    );
  }
}
