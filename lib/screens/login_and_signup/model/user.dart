class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.role,
  });

   Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Gender': gender,
      'Role': role
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['ID'] as String? ?? "field empty",
        firstName: json['First Name'] as String? ?? "field empty",
        lastName: json['Last Name'] as String? ?? "field empty",
        email: json['email'] as String? ?? "field empty",
        gender: json['Gender'] as String? ?? "field empty",
        role: json['Role'] as String? ?? "field empty");
  }

  String get userRole {
    // Add any additional logic you need to transform the role value
    return role;
  }
}
