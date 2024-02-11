// models/user_model.dart
class UserModel {
  final String token;

  UserModel({required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['response']['token']);
  }
}
