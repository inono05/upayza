class TransferFormRequest {
  TransferFormRequest({
    required this.userId,
    required this.operatorId,
    required this.depositNumberId,
    required this.recipientId,
    required this.recipientSvcNumber,
    required this.amount,
    required this.reason,
    required this.currency,
    required this.signature,
    required this.method,
  });

  final int? userId;
  final int? operatorId;
  final int? depositNumberId;
  final int? recipientId;
  final String? recipientSvcNumber;
  final int? amount;
  final String? reason;
  final String? currency;
  final String? signature;
  final String? method;

  TransferFormRequest copyWith({
    int? userId,
    int? operatorId,
    int? depositNumberId,
    int? recipientId,
    String? recipientSvcNumber,
    int? amount,
    String? reason,
    String? currency,
    String? signature,
    String? method,
  }) {
    return TransferFormRequest(
      userId: userId ?? this.userId,
      operatorId: operatorId ?? this.operatorId,
      depositNumberId: depositNumberId ?? this.depositNumberId,
      recipientId: recipientId ?? this.recipientId,
      recipientSvcNumber: recipientSvcNumber ?? this.recipientSvcNumber,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      currency: currency ?? this.currency,
      signature: signature ?? this.signature,
      method: method ?? this.method,
    );
  }

  factory TransferFormRequest.fromJson(Map<String, dynamic> json){
    return TransferFormRequest(
      userId: json["user_id"],
      operatorId: json["operator_id"],
      depositNumberId: json["deposit_number_id"],
      recipientId: json["recipient_id"],
      recipientSvcNumber: json["recipient_svc_number"],
      amount: json["amount"],
      reason: json["reason"],
      currency: json["currency"],
      signature: json["signature"],
      method: json["method"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "operator_id": operatorId,
    "deposit_number_id": depositNumberId,
    "recipient_id": recipientId,
    "recipient_svc_number": recipientSvcNumber,
    "amount": amount,
    "reason": reason,
    "currency": currency,
    "signature": signature,
    "method": method,
  };

  @override
  String toString(){
    return "$userId, $operatorId, $depositNumberId, $recipientId, $recipientSvcNumber, $amount, $reason, $currency, $signature, $method, ";
  }
}
