import 'dart:convert';

class JSonResponse {
  final String? message;
  final Errors? errors;

  JSonResponse({
    this.message,
    this.errors,
  });

  JSonResponse copyWith({
    String? message,
    Errors? errors,
  }) =>
      JSonResponse(
        message: message ?? this.message,
        errors: errors ?? this.errors,
      );

  factory JSonResponse.fromRawJson(String str) => JSonResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JSonResponse.fromJson(Map<String, dynamic> json) => JSonResponse(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  final List<String>? emailPhone;

  Errors({
    this.emailPhone,
  });

  Errors copyWith({
    List<String>? emailPhone,
  }) =>
      Errors(
        emailPhone: emailPhone ?? this.emailPhone,
      );

  factory Errors.fromRawJson(String str) => Errors.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    emailPhone: json["email|phone"] == null ? [] : List<String>.from(json["email|phone"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email|phone": emailPhone == null ? [] : List<dynamic>.from(emailPhone!.map((x) => x)),
  };
}
