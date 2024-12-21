import 'dart:convert';

import '../../features/Countries/domains/country.dart';

class OperatorJSonResponse {
  final List<Operator>? operators;

  OperatorJSonResponse({
    this.operators,
  });

  OperatorJSonResponse copyWith({
    List<Operator>? operators,
  }) =>
      OperatorJSonResponse(
        operators: operators ?? this.operators,
      );

  factory OperatorJSonResponse.fromRawJson(String str) => OperatorJSonResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OperatorJSonResponse.fromJson(Map<String, dynamic> json) => OperatorJSonResponse(
    operators: json["data"] == null ? [] : List<Operator>.from(json["data"]!.map((x) => Operator.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": operators == null ? [] : List<Operator>.from(operators!.map((x) => x.toJson())),
  };
}

class Operator {
  Operator({
    required this.id,
    required this.reference,
    required this.label,
    required this.country,
  });

  final int? id;
  final String? reference;
  final String? label;
  final Country? country;

  Operator copyWith({
    int? id,
    String? reference,
    String? label,
    Country? country,
  }) {
    return Operator(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      label: label ?? this.label,
      country: country ?? this.country,
    );
  }

  factory Operator.fromJson(Map<String, dynamic> json){
    return Operator(
      id: json["id"],
      reference: json["reference"],
      label: json["label"],
      country: json["country"] == null ? null : Country.fromJson(json["country"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "label": label,
    "country": country?.toJson(),
  };

  @override
  String toString(){
    return "$id, $reference, $label, $country, ";
  }
}


