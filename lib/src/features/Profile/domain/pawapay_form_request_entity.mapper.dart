// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pawapay_form_request_entity.dart';

class PawapayFormRequestEntityMapper
    extends ClassMapperBase<PawapayFormRequestEntity> {
  PawapayFormRequestEntityMapper._();

  static PawapayFormRequestEntityMapper? _instance;
  static PawapayFormRequestEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PawapayFormRequestEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PawapayFormRequestEntity';

  static int _$userId(PawapayFormRequestEntity v) => v.userId;
  static const Field<PawapayFormRequestEntity, int> _f$userId =
      Field('userId', _$userId, key: 'user_id');
  static int _$operatorId(PawapayFormRequestEntity v) => v.operatorId;
  static const Field<PawapayFormRequestEntity, int> _f$operatorId =
      Field('operatorId', _$operatorId, key: 'operator_id');
  static int _$recipientId(PawapayFormRequestEntity v) => v.recipientId;
  static const Field<PawapayFormRequestEntity, int> _f$recipientId =
      Field('recipientId', _$recipientId, key: 'recipient_id');
  static int _$amount(PawapayFormRequestEntity v) => v.amount;
  static const Field<PawapayFormRequestEntity, int> _f$amount =
      Field('amount', _$amount);
  static String _$currency(PawapayFormRequestEntity v) => v.currency;
  static const Field<PawapayFormRequestEntity, String> _f$currency =
      Field('currency', _$currency);
  static String _$signature(PawapayFormRequestEntity v) => v.signature;
  static const Field<PawapayFormRequestEntity, String> _f$signature =
      Field('signature', _$signature);
  static String _$method(PawapayFormRequestEntity v) => v.method;
  static const Field<PawapayFormRequestEntity, String> _f$method =
      Field('method', _$method);
  static String _$payerType(PawapayFormRequestEntity v) => v.payerType;
  static const Field<PawapayFormRequestEntity, String> _f$payerType =
      Field('payerType', _$payerType, key: 'payer_type');
  static String _$payerAddress(PawapayFormRequestEntity v) => v.payerAddress;
  static const Field<PawapayFormRequestEntity, String> _f$payerAddress =
      Field('payerAddress', _$payerAddress, key: 'payer_address');
  static String _$reason(PawapayFormRequestEntity v) => v.reason;
  static const Field<PawapayFormRequestEntity, String> _f$reason =
      Field('reason', _$reason);

  @override
  final MappableFields<PawapayFormRequestEntity> fields = const {
    #userId: _f$userId,
    #operatorId: _f$operatorId,
    #recipientId: _f$recipientId,
    #amount: _f$amount,
    #currency: _f$currency,
    #signature: _f$signature,
    #method: _f$method,
    #payerType: _f$payerType,
    #payerAddress: _f$payerAddress,
    #reason: _f$reason,
  };

  static PawapayFormRequestEntity _instantiate(DecodingData data) {
    return PawapayFormRequestEntity(
        data.dec(_f$userId),
        data.dec(_f$operatorId),
        data.dec(_f$recipientId),
        data.dec(_f$amount),
        data.dec(_f$currency),
        data.dec(_f$signature),
        data.dec(_f$method),
        data.dec(_f$payerType),
        data.dec(_f$payerAddress),
        data.dec(_f$reason));
  }

  @override
  final Function instantiate = _instantiate;

  static PawapayFormRequestEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PawapayFormRequestEntity>(map);
  }

  static PawapayFormRequestEntity fromJson(String json) {
    return ensureInitialized().decodeJson<PawapayFormRequestEntity>(json);
  }
}

mixin PawapayFormRequestEntityMappable {
  String toJson() {
    return PawapayFormRequestEntityMapper.ensureInitialized()
        .encodeJson<PawapayFormRequestEntity>(this as PawapayFormRequestEntity);
  }

  Map<String, dynamic> toMap() {
    return PawapayFormRequestEntityMapper.ensureInitialized()
        .encodeMap<PawapayFormRequestEntity>(this as PawapayFormRequestEntity);
  }

  PawapayFormRequestEntityCopyWith<PawapayFormRequestEntity,
          PawapayFormRequestEntity, PawapayFormRequestEntity>
      get copyWith => _PawapayFormRequestEntityCopyWithImpl(
          this as PawapayFormRequestEntity, $identity, $identity);
  @override
  String toString() {
    return PawapayFormRequestEntityMapper.ensureInitialized()
        .stringifyValue(this as PawapayFormRequestEntity);
  }

  @override
  bool operator ==(Object other) {
    return PawapayFormRequestEntityMapper.ensureInitialized()
        .equalsValue(this as PawapayFormRequestEntity, other);
  }

  @override
  int get hashCode {
    return PawapayFormRequestEntityMapper.ensureInitialized()
        .hashValue(this as PawapayFormRequestEntity);
  }
}

extension PawapayFormRequestEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PawapayFormRequestEntity, $Out> {
  PawapayFormRequestEntityCopyWith<$R, PawapayFormRequestEntity, $Out>
      get $asPawapayFormRequestEntity => $base
          .as((v, t, t2) => _PawapayFormRequestEntityCopyWithImpl(v, t, t2));
}

abstract class PawapayFormRequestEntityCopyWith<
    $R,
    $In extends PawapayFormRequestEntity,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? userId,
      int? operatorId,
      int? recipientId,
      int? amount,
      String? currency,
      String? signature,
      String? method,
      String? payerType,
      String? payerAddress,
      String? reason});
  PawapayFormRequestEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PawapayFormRequestEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PawapayFormRequestEntity, $Out>
    implements
        PawapayFormRequestEntityCopyWith<$R, PawapayFormRequestEntity, $Out> {
  _PawapayFormRequestEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PawapayFormRequestEntity> $mapper =
      PawapayFormRequestEntityMapper.ensureInitialized();
  @override
  $R call(
          {int? userId,
          int? operatorId,
          int? recipientId,
          int? amount,
          String? currency,
          String? signature,
          String? method,
          String? payerType,
          String? payerAddress,
          String? reason}) =>
      $apply(FieldCopyWithData({
        if (userId != null) #userId: userId,
        if (operatorId != null) #operatorId: operatorId,
        if (recipientId != null) #recipientId: recipientId,
        if (amount != null) #amount: amount,
        if (currency != null) #currency: currency,
        if (signature != null) #signature: signature,
        if (method != null) #method: method,
        if (payerType != null) #payerType: payerType,
        if (payerAddress != null) #payerAddress: payerAddress,
        if (reason != null) #reason: reason
      }));
  @override
  PawapayFormRequestEntity $make(CopyWithData data) => PawapayFormRequestEntity(
      data.get(#userId, or: $value.userId),
      data.get(#operatorId, or: $value.operatorId),
      data.get(#recipientId, or: $value.recipientId),
      data.get(#amount, or: $value.amount),
      data.get(#currency, or: $value.currency),
      data.get(#signature, or: $value.signature),
      data.get(#method, or: $value.method),
      data.get(#payerType, or: $value.payerType),
      data.get(#payerAddress, or: $value.payerAddress),
      data.get(#reason, or: $value.reason));

  @override
  PawapayFormRequestEntityCopyWith<$R2, PawapayFormRequestEntity, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PawapayFormRequestEntityCopyWithImpl($value, $cast, t);
}
