import 'package:health_connector_core/src/utils/collection.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ListEquality',
    () {
      group(
        'equals',
        () {
          test(
            'GIVEN two lists with the same elements in the same order → '
            'WHEN equals is called → '
            'THEN returns true',
            () {
              // GIVEN
              final list1 = [1, 2, 3];
              final list2 = [1, 2, 3];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isTrue);
            },
          );

          test(
            'GIVEN two lists with the same elements in different order → '
            'WHEN equals is called → '
            'THEN returns false',
            () {
              // GIVEN
              final list1 = [1, 2, 3];
              final list2 = [3, 2, 1];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isFalse);
            },
          );

          test(
            'GIVEN two lists with different lengths → '
            'WHEN equals is called → '
            'THEN returns false',
            () {
              // GIVEN
              final list1 = [1, 2, 3];
              final list2 = [1, 2];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isFalse);
            },
          );

          test(
            'GIVEN two empty lists → '
            'WHEN equals is called → '
            'THEN returns true',
            () {
              // GIVEN
              final list1 = <int>[];
              final list2 = <int>[];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isTrue);
            },
          );

          test(
            'GIVEN one empty list and one non-empty list → '
            'WHEN equals is called → '
            'THEN returns false',
            () {
              // GIVEN
              final list1 = <int>[];
              final list2 = [1, 2, 3];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isFalse);
            },
          );

          test(
            'GIVEN a list and null → '
            'WHEN equals is called → '
            'THEN returns false',
            () {
              // GIVEN
              final list1 = [1, 2, 3];

              // WHEN
              final result = list1.equals(null);

              // THEN
              expect(result, isFalse);
            },
          );

          test(
            'GIVEN the same list instance → '
            'WHEN equals is called → '
            'THEN returns true',
            () {
              // GIVEN
              final list1 = [1, 2, 3];

              // WHEN
              final result = list1.equals(list1);

              // THEN
              expect(result, isTrue);
            },
          );

          test(
            'GIVEN two lists containing nested lists → '
            'WHEN equals is called → '
            'THEN performs shallow equality check',
            () {
              // GIVEN
              final innerList1 = [1, 2];
              final innerList2 = [1, 2];
              final list1 = [innerList1];
              final list2 = [innerList2];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              // Should be false because shallow equality compares references
              expect(result, isFalse);
            },
          );

          test(
            'GIVEN two lists with same nested list instance → '
            'WHEN equals is called → '
            'THEN returns true',
            () {
              // GIVEN
              final innerList = [1, 2];
              final list1 = [innerList];
              final list2 = [innerList];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isTrue);
            },
          );

          test(
            'GIVEN two lists with different elements → '
            'WHEN equals is called → '
            'THEN returns false',
            () {
              // GIVEN
              final list1 = [1, 2, 3];
              final list2 = [1, 2, 4];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isFalse);
            },
          );

          test(
            'GIVEN two lists with string elements → '
            'WHEN equals is called → '
            'THEN correctly compares strings',
            () {
              // GIVEN
              final list1 = ['a', 'b', 'c'];
              final list2 = ['a', 'b', 'c'];

              // WHEN
              final result = list1.equals(list2);

              // THEN
              expect(result, isTrue);
            },
          );
        },
      );
    },
  );
}
