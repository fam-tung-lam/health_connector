import 'package:health_connector_core/health_connector_core.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('HealthConnectorException.fromCode', () {
    test('returns AuthorizationException for permissionNotGranted', () {
      final exception = HealthConnectorException.fromCode(
        HealthConnectorErrorCode.permissionNotGranted,
        'Permission denied',
      );

      expect(exception, isA<AuthorizationException>());
      expect(
        exception.code,
        HealthConnectorErrorCode.permissionNotGranted,
      );
      expect(exception.message, 'Permission denied');
    });

    test('returns ConfigurationException for permissionNotDeclared', () {
      final exception = HealthConnectorException.fromCode(
        HealthConnectorErrorCode.permissionNotDeclared,
        'Missing manifest entry',
      );

      expect(exception, isA<ConfigurationException>());
      expect(
        exception.code,
        HealthConnectorErrorCode.permissionNotDeclared,
      );
      expect(exception.message, 'Missing manifest entry');
    });

    test('returns InvalidArgumentException for invalidArgument', () {
      final exception = HealthConnectorException.fromCode(
        HealthConnectorErrorCode.invalidArgument,
        'Bad input',
      );

      expect(exception, isA<InvalidArgumentException>());
      expect(
        exception.code,
        HealthConnectorErrorCode.invalidArgument,
      );
      expect(exception.message, 'Bad input');
    });

    parameterizedTest(
      'returns HealthServiceUnavailableException',
      [
        HealthConnectorErrorCode.healthServiceUnavailable,
        HealthConnectorErrorCode.healthServiceRestricted,
        HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired,
      ],
      (HealthConnectorErrorCode code) {
        final exception = HealthConnectorException.fromCode(code, 'msg');

        expect(exception, isA<HealthServiceUnavailableException>());
        expect(exception.code, code);
        expect(exception.message, 'msg');
      },
    );

    parameterizedTest(
      'returns HealthServiceException',
      [
        HealthConnectorErrorCode.healthServiceDatabaseInaccessible,
        HealthConnectorErrorCode.ioError,
        HealthConnectorErrorCode.remoteError,
        HealthConnectorErrorCode.rateLimitExceeded,
        HealthConnectorErrorCode.dataSyncInProgress,
      ],
      (HealthConnectorErrorCode code) {
        final exception = HealthConnectorException.fromCode(code, 'msg');

        expect(exception, isA<HealthServiceException>());
        expect(exception.code, code);
        expect(exception.message, 'msg');
      },
    );

    test(
      'returns UnsupportedOperationException for unsupportedOperation',
      () {
        final exception = HealthConnectorException.fromCode(
          HealthConnectorErrorCode.unsupportedOperation,
          'Not supported',
        );

        expect(exception, isA<UnsupportedOperationException>());
        expect(
          exception.code,
          HealthConnectorErrorCode.unsupportedOperation,
        );
        expect(exception.message, 'Not supported');
      },
    );

    test('returns UnknownException for unknownError', () {
      final exception = HealthConnectorException.fromCode(
        HealthConnectorErrorCode.unknownError,
        'Something went wrong',
      );

      expect(exception, isA<UnknownException>());
      expect(
        exception.code,
        HealthConnectorErrorCode.unknownError,
      );
      expect(exception.message, 'Something went wrong');
    });

    group('preserves optional parameters', () {
      test('preserves cause', () {
        final cause = Exception('root cause');
        final exception = HealthConnectorException.fromCode(
          HealthConnectorErrorCode.ioError,
          'Disk failure',
          cause: cause,
        );

        expect(exception.cause, cause);
      });

      test('preserves stackTrace', () {
        final stackTrace = StackTrace.current;
        final exception = HealthConnectorException.fromCode(
          HealthConnectorErrorCode.ioError,
          'Disk failure',
          stackTrace: stackTrace,
        );

        expect(exception.stackTrace, stackTrace);
      });

      test('cause and stackTrace default to null', () {
        final exception = HealthConnectorException.fromCode(
          HealthConnectorErrorCode.unknownError,
          'Error',
        );

        expect(exception.cause, isNull);
        expect(exception.stackTrace, isNull);
      });
    });
  });

  group('HealthConnectorException equality', () {
    test('equal exceptions with same properties', () {
      const a = InvalidArgumentException('Bad input');
      const b = InvalidArgumentException('Bad input');

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('not equal with different message', () {
      const a = InvalidArgumentException('Bad input');
      const b = InvalidArgumentException('Different message');

      expect(a, isNot(equals(b)));
    });

    test('not equal with different type', () {
      const a = InvalidArgumentException('Error');
      const b = UnknownException('Error');

      expect(a, isNot(equals(b)));
    });

    test('not equal with different cause', () {
      final a = InvalidArgumentException(
        'Bad',
        cause: Exception('x'),
      );
      final b = InvalidArgumentException(
        'Bad',
        cause: Exception('y'),
      );

      expect(a, isNot(equals(b)));
    });

    test('not equal with different stackTrace', () {
      final a = InvalidArgumentException(
        'Bad',
        stackTrace: StackTrace.current,
      );
      const b = InvalidArgumentException('Bad');

      expect(a, isNot(equals(b)));
    });
  });

  group('HealthConnectorException toString', () {
    test('includes code and message', () {
      const exception = InvalidArgumentException('Bad input');
      final result = exception.toString();

      expect(result, contains('INVALID_ARGUMENT'));
      expect(result, contains('Bad input'));
    });

    test('includes cause when present', () {
      final exception = HealthConnectorException.fromCode(
        HealthConnectorErrorCode.ioError,
        'Disk failure',
        cause: 'root cause',
      );
      final result = exception.toString();

      expect(result, contains('cause=root cause'));
    });

    test('excludes cause when null', () {
      const exception = InvalidArgumentException('Bad input');
      final result = exception.toString();

      expect(result, isNot(contains('cause=')));
    });

    test('includes stackTrace when present', () {
      final st = StackTrace.current;
      final exception = HealthConnectorException.fromCode(
        HealthConnectorErrorCode.ioError,
        'Disk failure',
        stackTrace: st,
      );
      final result = exception.toString();

      expect(result, contains('stackTrace='));
    });

    test('excludes stackTrace when null', () {
      const exception = InvalidArgumentException('Bad input');
      final result = exception.toString();

      expect(result, isNot(contains('stackTrace=')));
    });
  });

  group('HealthConnectorErrorCode', () {
    test('each code has a unique string representation', () {
      final codes = HealthConnectorErrorCode.values.map((c) => c.code).toList();
      expect(codes.toSet().length, equals(codes.length));
    });

    test('all error codes map to an exception via fromCode', () {
      for (final code in HealthConnectorErrorCode.values) {
        final exception = HealthConnectorException.fromCode(
          code,
          'test message',
        );
        expect(exception, isA<HealthConnectorException>());
        expect(exception.message, 'test message');
      }
    });
  });
}
