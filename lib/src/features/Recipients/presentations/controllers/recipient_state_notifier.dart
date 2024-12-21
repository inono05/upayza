import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/core/repository/operator_repository.dart';

final recipientOperatorIdProvider = StateProvider<int?>((ref) => null);
final recipientOperator = StateProvider<Operator?>((ref) {
  final List<Operator> operators = ref.watch(operatorsProvider).maybeWhen(
        data: (data) => data.operators!,
        orElse: () => [],
      );
log("starting point");
  final recipientOperatorId = ref.watch(recipientOperatorIdProvider);
  log("process point: $recipientOperatorId");
  return (recipientOperatorId != null)
      ? operators.firstWhere((e) => e.id == recipientOperatorId)
      : null;
});
