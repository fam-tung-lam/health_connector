import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A characteristic reader's observable state.
sealed class UserCharacteristicReadState {
  const UserCharacteristicReadState();
}

/// No read has completed for the selection.
final class CharacteristicIdle extends UserCharacteristicReadState {
  const CharacteristicIdle();
}

/// One read is in flight.
final class CharacteristicReading extends UserCharacteristicReadState {
  const CharacteristicReading();
}

/// A birth date returned by the selected operation.
final class BirthDateRead extends UserCharacteristicReadState {
  const BirthDateRead(this.value);
  final BirtDate value;
}

/// A biological-sex value returned by the selected operation.
final class BiologicalSexRead extends UserCharacteristicReadState {
  const BiologicalSexRead(this.value);
  final BiologicalSex value;
}

/// The selected characteristic has no readable data.
final class CharacteristicUnavailable extends UserCharacteristicReadState {
  const CharacteristicUnavailable();
}

/// An explicit read failure.
final class CharacteristicReadFailure extends UserCharacteristicReadState {
  const CharacteristicReadFailure(this.message);
  final String message;
}

/// Owns transient characteristic results for one route.
final class ReadUserCharacteristicChangeNotifier extends ChangeNotifier {
  ReadUserCharacteristicChangeNotifier(this._connector);

  final HealthConnector _connector;
  UserCharacteristicType<Object> _selected = UserCharacteristicType.birthDate;
  UserCharacteristicReadState _state = const CharacteristicIdle();
  bool _disposed = false;
  int _request = 0;

  UserCharacteristicType<Object> get selectedCharacteristic => _selected;
  UserCharacteristicReadState get state => _state;
  bool get isReading => _state is CharacteristicReading;
  bool get isSupported => _connector
      .getSupportStatusFor(_selected.healthPlatformRequirements)
      .isSupported;
  bool get canRead => !_disposed && isSupported && !isReading;

  void selectCharacteristic(UserCharacteristicType<Object>? value) {
    if (_disposed || value == null || value == _selected) {
      return;
    }
    _request++;
    _selected = value;
    _state = const CharacteristicIdle();
    notifyListeners();
  }

  Future<void> readSelectedCharacteristic() async {
    if (!canRead) {
      return;
    }
    final request = ++_request;
    final selected = _selected;
    _state = const CharacteristicReading();
    notifyListeners();
    UserCharacteristicReadState next;
    try {
      next = switch (selected) {
        BirthDateCharacteristicType() => switch (await _connector
            .readUserCharacteristic(UserCharacteristicType.birthDate)) {
          final BirtDate value => BirthDateRead(value),
          null => const CharacteristicUnavailable(),
        },
        BiologicalSexCharacteristicType() => switch (await _connector
            .readUserCharacteristic(
              UserCharacteristicType.biologicalSex,
            )) {
          final BiologicalSex value => BiologicalSexRead(value),
          null => const CharacteristicUnavailable(),
        },
      };
    } on AuthorizationException {
      next = const CharacteristicReadFailure(
        AppTexts.characteristicAuthorizationRequired,
      );
    } on HealthConnectorException catch (error) {
      next = CharacteristicReadFailure(error.message);
    } on Exception {
      next = const CharacteristicReadFailure(
        'Failed to read user characteristic.',
      );
    }
    if (_disposed || request != _request) {
      return;
    }
    _state = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _request++;
    _state = const CharacteristicIdle();
    super.dispose();
  }
}
