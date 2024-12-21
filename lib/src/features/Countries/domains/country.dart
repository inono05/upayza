import 'dart:convert';

class Country {
  final int? id;
  final String? label;
  final String? code;
  final String? countryCode;
  final String? currency;
  final String? flag;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Country({
    this.id,
    this.label,
    this.code,
    this.countryCode,
    this.currency,
    this.flag,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Country copyWith({
    int? id,
    String? label,
    String? code,
    String? countryCode,
    String? currency,
    String? flag,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Country(
        id: id ?? this.id,
        label: label ?? this.label,
        code: code ?? this.code,
        countryCode: countryCode ?? this.countryCode,
        currency: currency ?? this.currency,
        flag: flag ?? this.flag,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    label: json["label"],
    code: json["code"],
    countryCode: json["country_code"],
    currency: json["currency"],
    flag: json["flag"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "code": code,
    "country_code": countryCode,
    "currency": currency,
    "flag": flag,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}