import 'package:upayza/src/core/models/operator_json_response.dart';

class RecipientJSonResponse {
  RecipientJSonResponse({
    required this.recipients,
  });

  final List<Recipient> recipients;

  RecipientJSonResponse copyWith({
    List<Recipient>? recipients,
  }) {
    return RecipientJSonResponse(
      recipients: recipients ?? this.recipients,
    );
  }

  factory RecipientJSonResponse.fromJson(Map<String, dynamic> json) {
    return RecipientJSonResponse(
      recipients: json["data"] == null
          ? []
          : List<Recipient>.from(
              json["data"]!.map(
                (x) => Recipient.fromJson(x),
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": recipients.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$recipients, ";
  }
}

class Recipient {
  Recipient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.number,
    required this.operator,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? number;
  final Operator? operator;

  Recipient copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? number,
    Operator? operator,
  }) {
    return Recipient(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      number: number ?? this.number,
      operator: operator ?? this.operator,
    );
  }

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      number: json["number"],
      operator:
          json["operator"] == null ? null : Operator.fromJson(json["operator"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "number": number,
        "operator": operator?.toJson(),
      };

  @override
  String toString() {
    return "$id, $firstName, $lastName, $email, $number, $operator, ";
  }

}

class RecipientObjectJSonResponse {
  RecipientObjectJSonResponse({
    required this.recipient,
  });

  final Recipient? recipient;

  RecipientObjectJSonResponse copyWith({
    Recipient? recipient,
  }) {
    return RecipientObjectJSonResponse(
      recipient: recipient ?? this.recipient,
    );
  }

  factory RecipientObjectJSonResponse.fromJson(Map<String, dynamic> json) {
    return RecipientObjectJSonResponse(
      recipient: json["data"] == null ? null : Recipient.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": recipient?.toJson(),
      };

  @override
  String toString() {
    return "$recipient, ";
  }
}

extension RecipientExtension on Recipient? {
  bool get isNull => this == null;
}
