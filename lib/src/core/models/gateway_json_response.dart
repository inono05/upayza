import 'dart:convert';


class GatewayJSonResponse {
  final List<Gateway>? gateways;

  GatewayJSonResponse({
    this.gateways,
  });

  GatewayJSonResponse copyWith({
    List<Gateway>? gateways,
  }) =>
      GatewayJSonResponse(
        gateways: gateways ?? this.gateways,
      );

  factory GatewayJSonResponse.fromRawJson(String str) => GatewayJSonResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GatewayJSonResponse.fromJson(Map<String, dynamic> json) => GatewayJSonResponse(
    gateways: json["data"] == null ? [] : List<Gateway>.from(json["data"]!.map((x) => Gateway.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": gateways == null ? [] : List<Gateway>.from(gateways!.map((x) => x.toJson())),
  };
}

class Gateway {
  final int? id;
  final String? label;
  final String? reference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Gateway({
    this.id,
    this.label,
    this.reference,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Gateway copyWith({
    int? id,
    String? label,
    String? reference,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Gateway(
        id: id ?? this.id,
        label: label ?? this.label,
        reference: reference ?? this.reference,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Gateway.fromRawJson(String str) => Gateway.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
    id: json["id"],
    label: json["label"],
    reference: json["reference"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "reference": reference,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

