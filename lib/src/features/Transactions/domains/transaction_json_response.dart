import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_json_response.dart';

class TransactionJSonResponse {
  TransactionJSonResponse({
    required this.transactions,
  });

  final List<Transaction> transactions;

  TransactionJSonResponse copyWith({
    List<Transaction>? transactions,
  }) {
    return TransactionJSonResponse(
      transactions: transactions ?? this.transactions,
    );
  }

  factory TransactionJSonResponse.fromJson(Map<String, dynamic> json){
    return TransactionJSonResponse(
      transactions: json["data"] == null ? [] : List<Transaction>.from(json["data"]!.map((x) => Transaction.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": transactions.map((x) => x.toJson()).toList(),
  };

  @override
  String toString(){
    return "$transactions, ";
  }
}

class Transaction {
  Transaction({
    required this.reference,
    required this.netAmount,
    required this.feeAmount,
    required this.status,
    required this.reason,
    required this.operatorAmount,
    required this.currency,
    required this.transactionOperator,
    required this.recipient,
    required this.createdAt,
  });

  final String? reference;
  final int? netAmount;
  final int? feeAmount;
  final String? status;
  final String? reason;
  final int? operatorAmount;
  final String? currency;
  final Operator? transactionOperator;
  final Recipient? recipient;
  final DateTime? createdAt;

  Transaction copyWith({
    String? reference,
    int? netAmount,
    int? feeAmount,
    String? status,
    String? reason,
    int? operatorAmount,
    String? currency,
    Operator? transactionOperator,
    Recipient? recipient,
    DateTime? createdAt,
  }) {
    return Transaction(
      reference: reference ?? this.reference,
      netAmount: netAmount ?? this.netAmount,
      feeAmount: feeAmount ?? this.feeAmount,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      operatorAmount: operatorAmount ?? this.operatorAmount,
      currency: currency ?? this.currency,
      transactionOperator: transactionOperator ?? this.transactionOperator,
      recipient: recipient ?? this.recipient,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      reference: json["reference"],
      netAmount: json["net_amount"],
      feeAmount: json["fee_amount"],
      status: json["status"],
      reason: json["reason"],
      operatorAmount: json["operator_amount"],
      currency: json["currency"],
      transactionOperator: json["operator"] == null ? null : Operator.fromJson(json["operator"]),
      recipient: json["recipient"] == null ? null : Recipient.fromJson(json["recipient"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "net_amount": netAmount,
    "fee_amount": feeAmount,
    "status": status,
    "reason": reason,
    "operator_amount": operatorAmount,
    "currency": currency,
    "operator": transactionOperator?.toJson(),
    "recipient": recipient?.toJson(),
    "created_at": createdAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$reference, $netAmount, $feeAmount, $status, $reason, $operatorAmount, $currency, $transactionOperator, $recipient, $createdAt, ";
  }
}



class TransactionObjectJSonResponse {
  TransactionObjectJSonResponse({
    required this.payoutId,
    required this.depositId,
    required this.status,
    required this.created,
    required this.errorId,
    required this.errorCode,
    required this.errorMessage,
  });

  final dynamic payoutId;
  final String? depositId;
  final String? status;
  final dynamic created;
  final dynamic errorId;
  final dynamic errorCode;
  final dynamic errorMessage;

  TransactionObjectJSonResponse copyWith({
    String? payoutId,
    String? depositId,
    String? status,
    String? created,
    String? errorId,
    String? errorCode,
    String? errorMessage,
  }) {
    return TransactionObjectJSonResponse(
      payoutId: payoutId ?? this.payoutId,
      depositId: depositId ?? this.depositId,
      status: status ?? this.status,
      created: created ?? this.created,
      errorId: errorId ?? this.errorId,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory TransactionObjectJSonResponse.fromJson(Map<String, dynamic> json){
    return TransactionObjectJSonResponse(
      payoutId: json["payoutId"],
      depositId: json["depositId"],
      status: json["status"],
      created: json["created"],
      errorId: json["errorId"],
      errorCode: json["errorCode"],
      errorMessage: json["errorMessage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "payoutId": payoutId,
    "depositId": depositId,
    "status": status,
    "created": created,
    "errorId": errorId,
    "errorCode": errorCode,
    "errorMessage": errorMessage,
  };

  @override
  String toString(){
    return "$payoutId, $depositId, $status, $created, $errorId, $errorCode, $errorMessage, ";
  }
}

