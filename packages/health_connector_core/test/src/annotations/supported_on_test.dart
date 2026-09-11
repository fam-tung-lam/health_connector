// ignore_for_file: deprecated_member_use_from_same_package

import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  test('legacy platform support annotations remain available', () {
    expect(
      <Object>[
        supportedOnHealthConnect,
        supportedOnHealthConnectSdkExtension21,
        supportedOnAppleHealth,
        supportedOnAppleHealthIOS16Plus,
        supportedOnAppleHealthIOS17Plus,
        supportedOnAppleHealthIOS18Plus,
      ],
      hasLength(6),
    );
  });
}
