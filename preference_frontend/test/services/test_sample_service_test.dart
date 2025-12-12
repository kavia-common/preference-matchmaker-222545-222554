import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// A minimal service contract to demonstrate mocktail usage within tests only.
abstract class UserService {
  // PUBLIC_INTERFACE
  Future<String> fetchGreeting(String userId);
}

class MockUserService extends Mock implements UserService {}

void main() {
  group('UserService with mocktail', () {
    late MockUserService mock;

    setUpAll(() {
      registerFallbackValue('user-123');
    });

    setUp(() {
      mock = MockUserService();
    });

    test('returns greeting and verifies interaction', () async {
      when(() => mock.fetchGreeting(any())).thenAnswer((_) async => 'Hello Alice');

      final result = await mock.fetchGreeting('user-1');

      expect(result, 'Hello Alice');
      verify(() => mock.fetchGreeting('user-1')).called(1);
      verifyNoMoreInteractions(mock);
    });

    test('throws error path', () async {
      when(() => mock.fetchGreeting(any())).thenThrow(Exception('network'));

      expect(() => mock.fetchGreeting('user-2'), throwsA(isA<Exception>()));
      verify(() => mock.fetchGreeting('user-2')).called(1);
    });
  });
}
