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
      when(
        () => mock.fetchGreeting(any()),
      ).thenAnswer((_) async => 'Hello Alice');

      final result = await mock.fetchGreeting('user-1');

      expect(result, 'Hello Alice');
      verify(() => mock.fetchGreeting('user-1')).called(1);
      verifyNoMoreInteractions(mock);
    });

    test('throws error path', () async {
      // Stub the specific argument to avoid loose any() mismatch and ensure deterministic behavior.
      when(() => mock.fetchGreeting('user-2')).thenThrow(Exception('network'));

      // Assert the call throws before verifying interactions.
      expect(() => mock.fetchGreeting('user-2'), throwsA(isA<Exception>()));

      // Verify it was invoked exactly once.
      verify(() => mock.fetchGreeting('user-2')).called(1);
    });
  });
}
