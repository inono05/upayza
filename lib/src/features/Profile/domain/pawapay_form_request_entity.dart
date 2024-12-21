import 'package:dart_mappable/dart_mappable.dart';

part 'pawapay_form_request_entity.mapper.dart';

@MappableClass()
class PawapayFormRequestEntity with PawapayFormRequestEntityMappable {
  @MappableField(key: 'user_id')
  int userId;
  @MappableField(key: 'operator_id')
  int operatorId;
  @MappableField(key: 'recipient_id')
  int recipientId;
  int amount;
  String currency;
  String signature;
  String method;
  @MappableField(key: 'payer_type')
  String payerType;
  @MappableField(key: 'payer_address')
  String payerAddress;
  String reason;

  PawapayFormRequestEntity(
      this.userId,
      this.operatorId,
      this.recipientId,
      this.amount,
      this.currency,
      this.signature,
      this.method,
      this.payerType,
      this.payerAddress,
      this.reason);

  factory PawapayFormRequestEntity.fromMap(Map<String, dynamic> map) =>
      PawapayFormRequestEntityMapper.fromMap(map);

  factory PawapayFormRequestEntity.fromJson(String json) =>
      PawapayFormRequestEntityMapper.fromJson(json);

  static PawapayFormRequestEntityMapper ensureInitialized() =>
      PawapayFormRequestEntityMapper.ensureInitialized();
}
