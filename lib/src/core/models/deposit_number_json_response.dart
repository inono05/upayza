import 'operator_json_response.dart';

class DepositNumberJSonResponse {
  DepositNumberJSonResponse({
    required this.depositNumbers,
  });

  final List<DepositNumber> depositNumbers;

  DepositNumberJSonResponse copyWith({
    List<DepositNumber>? depositNumbers,
  }) {
    return DepositNumberJSonResponse(
      depositNumbers: depositNumbers ?? this.depositNumbers,
    );
  }

  factory DepositNumberJSonResponse.fromJson(Map<String, dynamic> json) {
    return DepositNumberJSonResponse(
      depositNumbers: json["data"] == null
          ? []
          : List<DepositNumber>.from(
              json["data"]!.map((x) => DepositNumber.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": depositNumbers.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$depositNumbers, ";
  }
}

class DepositNumber {
  DepositNumber({
    required this.id,
    required this.value,
    required this.operator,
  });

  final int? id;
  final String? value;
  final Operator? operator;

  DepositNumber copyWith({
    int? id,
    String? value,
    Operator? operator,
  }) {
    return DepositNumber(
      id: id ?? this.id,
      value: value ?? this.value,
      operator: operator ?? this.operator,
    );
  }

  factory DepositNumber.fromJson(Map<String, dynamic> json) {
    return DepositNumber(
      id: json["id"],
      value: json["value"],
      operator:
          json["operator"] == null ? null : Operator.fromJson(json["operator"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "operator": operator?.toJson(),
      };

  @override
  String toString() {
    return "$id, $value, $operator, ";
  }

  bool isNull() {
    return identical(this, null);
  }
}

class DepositNumberObjectJSonResponse {
  DepositNumberObjectJSonResponse({
    required this.depositNumber,
  });

  final DepositNumber? depositNumber;

  DepositNumberObjectJSonResponse copyWith({
    DepositNumber? depositNumber,
  }) {
    return DepositNumberObjectJSonResponse(
      depositNumber: depositNumber ?? this.depositNumber,
    );
  }

  factory DepositNumberObjectJSonResponse.fromJson(Map<String, dynamic> json) {
    return DepositNumberObjectJSonResponse(
      depositNumber:
          json["data"] == null ? null : DepositNumber.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": depositNumber?.toJson(),
      };

  @override
  String toString() {
    return "$depositNumber, ";
  }
}
