import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_type_extension.dart';

void main() {
  group('ExerciseTypeDisplayName', () {
    test('uses explicit cycling environment names', () {
      expect(ExerciseType.cycling.displayName, 'Outdoor Cycling');
      expect(ExerciseType.cyclingStationary.displayName, 'Indoor Cycling');
    });
  });
}
