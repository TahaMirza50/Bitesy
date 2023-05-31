import 'package:Bitesy/features/login_and_signup/data/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel Tests', () {
    // Test data
    final userJson = {
      'ID': '123',
      'First Name': 'John',
      'Last Name': 'Doe',
      'Email': 'john.doe@example.com',
      'Gender': 'Male',
      'Role': 'User',
      'Avatar': 'avatar.jpg',
    };

    test('fromJson() should return a valid UserModel object', () {
      // Act
      final userModel = UserModel.fromJson(userJson);

      // Assert
      expect(userModel.id, '123');
      expect(userModel.firstName, 'John');
      expect(userModel.lastName, 'Doe');
      expect(userModel.email, 'john.doe@example.com');
      expect(userModel.gender, 'Male');
      expect(userModel.role, 'User');
      expect(userModel.avatar, 'avatar.jpg');
    });

    test('toJson() should return a valid JSON map', () {
      // Arrange
      final userModel = UserModel(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        gender: 'Male',
        role: 'User',
        avatar: 'avatar.jpg',
      );

      // Act
      final json = userModel.toJson();

      // Assert
      expect(json['ID'], '123');
      expect(json['First Name'], 'John');
      expect(json['Last Name'], 'Doe');
      expect(json['Email'], 'john.doe@example.com');
      expect(json['Gender'], 'Male');
      expect(json['Role'], 'User');
      expect(json['Avatar'], 'avatar.jpg');
    });

    test('userRole getter should return the correct role', () {
      // Arrange
      final userModel = UserModel(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        gender: 'Male',
        role: 'User',
        avatar: 'avatar.jpg',
      );

      // Act
      final role = userModel.userRole;

      // Assert
      expect(role, 'User');
    });
  });
}
