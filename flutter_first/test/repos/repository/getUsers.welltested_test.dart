//import 'getUsers.welltested_test.mocks.dart';//import 'getUsers.welltested_test.mocks.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_first/model/user_model.dart';
import 'package:flutter_first/repos/repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as testMock;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'getUsers.welltested_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('UserRepository', () {
    final clientMock = MockClient();
    final userRepository = UserRepository();

    test('getUsers returns a list of UserModel when the API call is successful',
        () async {
      // Arrange
      final response = http.Response(
        json.encode({
          'data': [
            {
              'id': 1,
              'email': 'test1@example.com',
              'first_name': 'Test1',
              'last_name': 'User1',
              'avatar': 'https://example.com/avatar1.jpg',
            },
            {
              'id': 2,
              'email': 'test2@example.com',
              'first_name': 'Test2',
              'last_name': 'User2',
              'avatar': 'https://example.com/avatar2.jpg',
            },
          ],
        }),
        200,
      );
      when(clientMock.get(any)).thenAnswer((_) async => response);

      // Act
      final result = await userRepository.getUsers();

      // Assert
      expect(result, [
        UserModel(
          id: 1,
          email: 'test1@example.com',
          firstName: 'Test1',
          lastName: 'User1',
          avatar: 'https://example.com/avatar1.jpg',
        ),
        UserModel(
          id: 2,
          email: 'test2@example.com',
          firstName: 'Test2',
          lastName: 'User2',
          avatar: 'https://example.com/avatar2.jpg',
        ),
      ]);
    });

    test('getUsers returns null when the API call fails', () async {
      // Arrange
      final response = http.Response('Failed to load users', 500);
      when(clientMock.get(any)).thenAnswer((_) async => response);

      // Act
      final result = await userRepository.getUsers();

      // Assert
      expect(result, null);
    });
  });
}
