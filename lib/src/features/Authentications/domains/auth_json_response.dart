import 'dart:convert';

import 'package:upayza/src/core/models/user.dart';

class AuthJSonResponse {
  final bool? success;
  final String? message;
  final User? user;
  final String? token;

  AuthJSonResponse({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  AuthJSonResponse copyWith({
    bool? success,
    String? message,
    User? user,
    String? token,
  }) =>
      AuthJSonResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory AuthJSonResponse.fromRawJson(String str) => AuthJSonResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthJSonResponse.fromJson(Map<String, dynamic> json) => AuthJSonResponse(
    success: json["success"],
    message: json["message"],
    user: json["data"] == null ? null : User.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": user?.toJson(),
    "token": token,
  };
}

extension AuthJsonExtension on AuthJSonResponse? {
  bool get isNotNull => this != null;
}