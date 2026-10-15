import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/user_characteristic_type_ui_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/console_logs/widgets/console_logs_action_button.dart';
import 'package:health_connector_toolbox/src/features/read_user_characteristic/read_user_characteristic_change_notifier.dart';
import 'package:provider/provider.dart';

/// Reads one selected user characteristic on demand.
final class ReadUserCharacteristicPage extends StatelessWidget {
  const ReadUserCharacteristicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ReadUserCharacteristicChangeNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.readUserCharacteristic),
        actions: const [ConsoleLogsActionButton()],
      ),
      body: !notifier.isSupported
          ? const Center(child: Text(AppTexts.characteristicUnsupported))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child:
                      SearchableDropdownMenuFormField<
                        UserCharacteristicType<Object>
                      >(
                        key: ValueKey(notifier.selectedCharacteristic),
                        labelText: AppTexts.userCharacteristicType,
                        values: const [
                          UserCharacteristicType.birthDate,
                          UserCharacteristicType.biologicalSex,
                        ],
                        initialValue: notifier.selectedCharacteristic,
                        displayNameBuilder: (type) => type.displayName,
                        enabled: !notifier.isReading,
                        onChanged: notifier.selectCharacteristic,
                      ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: _CharacteristicResult(state: notifier.state),
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: notifier.canRead
                            ? () => _read(context, notifier)
                            : null,
                        child: Text(AppTexts.read.toUpperCase()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _read(
    BuildContext context,
    ReadUserCharacteristicChangeNotifier notifier,
  ) async {
    await notifier.readSelectedCharacteristic();
    if (!context.mounted) {
      return;
    }
    if (notifier.state case CharacteristicReadFailure(:final message)) {
      showAppSnackBar(context, SnackBarType.error, message);
    }
  }
}

final class _CharacteristicResult extends StatelessWidget {
  const _CharacteristicResult({required this.state});
  final UserCharacteristicReadState state;

  @override
  Widget build(BuildContext context) => switch (state) {
    CharacteristicIdle() ||
    CharacteristicReadFailure() => const SizedBox.shrink(),
    CharacteristicReading() => const Center(child: CircularProgressIndicator()),
    CharacteristicUnavailable() => const Text(
      AppTexts.characteristicUnavailable,
      textAlign: TextAlign.center,
    ),
    BirthDateRead(:final value) => Text(
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}',
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    ),
    BiologicalSexRead(:final value) => Text(
      switch (value) {
        BiologicalSex.female => 'Female',
        BiologicalSex.male => 'Male',
        BiologicalSex.other => 'Other',
      },
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    ),
  };
}
