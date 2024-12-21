import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';

final isDetailTileOpenProvider = StateProvider<bool>((ref) => false);
final transactionProvider = StateProvider<Transaction?>((ref) => null);