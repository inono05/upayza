import 'dart:convert';

class User {
  final String? lastName;
  final String? firstName;
  final int? countryId;
  final String? email;
  final String? phone;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final DateTime? emailVerifiedAt;
  final int? id;
  final List<dynamic>? roles;

  User({
    this.lastName,
    this.firstName,
    this.countryId,
    this.email,
    this.phone,
    this.updatedAt,
    this.createdAt,
    this.emailVerifiedAt,
    this.id,
    this.roles,
  });

  User copyWith({
    String? lastName,
    String? firstName,
    int? countryId,
    String? email,
    String? phone,
    DateTime? updatedAt,
    DateTime? createdAt,
    DateTime? emailVerifiedAt,
    int? id,
    List<dynamic>? roles,
  }) =>
      User(
        lastName: lastName ?? this.lastName,
        firstName: firstName ?? this.firstName,
        countryId: countryId ?? this.countryId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        id: id ?? this.id,
        roles: roles ?? this.roles,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    lastName: json["last_name"],
    firstName: json["first_name"],
    countryId: json["country_id"],
    email: json["email"],
    phone: json["phone"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    id: json["id"],
    roles: json["roles"] == null ? [] : List<dynamic>.from(json["roles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "last_name": lastName,
    "first_name": firstName,
    "country_id": countryId,
    "email": email,
    "phone": phone,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "id": id,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
  };
}