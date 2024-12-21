class DepositNumberFormRequest {
  DepositNumberFormRequest({
    required this.userId,
    required this.operatorId,
    required this.value,
  });

  final int? userId;
  final int? operatorId;
  final String? value;

  DepositNumberFormRequest copyWith({
    int? userId,
    int? operatorId,
    String? value,
  }) {
    return DepositNumberFormRequest(
      userId: userId ?? this.userId,
      operatorId: operatorId ?? this.operatorId,
      value: value ?? this.value,
    );
  }

  factory DepositNumberFormRequest.fromJson(Map<String, dynamic> json){
    return DepositNumberFormRequest(
      userId: json["user_id"],
      operatorId: json["operator_id"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "operator_id": operatorId,
    "value": value,
  };

  @override
  String toString(){
    return "$userId, $operatorId, $value, ";
  }
}
