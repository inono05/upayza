import 'dart:convert';

import 'package:upayza/src/features/Countries/domains/country.dart';

class CountriesJSonResponse {
  final List<Country>? countries;

  CountriesJSonResponse({
    this.countries,
  });

  CountriesJSonResponse copyWith({
    List<Country>? countries,
  }) =>
      CountriesJSonResponse(
        countries: countries ?? this.countries,
      );

  factory CountriesJSonResponse.fromRawJson(String str) =>
      CountriesJSonResponse.fromJson(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  factory CountriesJSonResponse.fromJson(Map<String, dynamic> json) =>
      CountriesJSonResponse(
        countries: json["data"] == null
            ? []
            : List<Country>.from(
                json["data"]!.map(
                  (x) => Country.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "data": countries == null
            ? []
            : List<dynamic>.from(
                countries!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
