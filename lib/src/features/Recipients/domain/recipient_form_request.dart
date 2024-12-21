class RecipientFormRequest {

  RecipientFormRequest({
    required this.userId,
    required this.operatorId,
    required this.number,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  final int? userId;
  final int? operatorId;
  final String? number;
  final String? email;
  final String? firstName;
  final String? lastName;

  RecipientFormRequest copyWith({
    int? userId,
    int? operatorId,
    String? number,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return RecipientFormRequest(
      userId: userId ?? this.userId,
      operatorId: operatorId ?? this.operatorId,
      number: number ?? this.number,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  factory RecipientFormRequest.fromJson(Map<String, dynamic> json){
    return RecipientFormRequest(
      userId: json["user_id"],
      operatorId: json["operator_id"],
      number: json["number"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "operator_id": operatorId,
    "number": number,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
  };

  @override
  String toString(){
    return "$userId, $operatorId, $number, $email, $firstName, $lastName, ";
  }
}
