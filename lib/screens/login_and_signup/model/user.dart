class UserModel{
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

  toJson(){
    return{
      'ID': id,
      'First Name' : firstName,
      'Last Name' : lastName,
      'Email': email,
      'Gender': gender,
      'Role': role 
    };
  }
}