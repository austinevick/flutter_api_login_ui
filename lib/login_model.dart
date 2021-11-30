import 'dart:convert';

LoginModel loginModel(String str) => LoginModel.fromMap(json.decode(str));

class LoginModel {
  final String email;
  final String password;
  LoginModel({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
  @override
  String toString() => 'LoginModel(email: $email, password: $password)';
}
