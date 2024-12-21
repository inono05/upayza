

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/features/Transactions/domains/transfer_form_request.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

import '../domains/transaction_json_response.dart';

part 'transaction_repository.g.dart';

abstract class ITransactionRepository{
  Future<TransactionJSonResponse> transfers();
  Future<TransactionObjectJSonResponse> transfer(TransferFormRequest request);
}

class TransactionRepository extends BaseRepository implements ITransactionRepository{
  TransactionRepository(super.api);

  @override
  Future<TransactionJSonResponse> transfers() {
    return this.api.transfers(AppUserPreferences().userId()!);
  }

  @override
  Future<TransactionObjectJSonResponse> transfer(TransferFormRequest request) {
    return this.api.transfer(request);
  }

}


@Riverpod(keepAlive: true)
TransactionRepository transactionRepository (TransactionRepositoryRef ref) {
  return TransactionRepository(ref.watch(apiProvider));
}

@Riverpod(keepAlive: true)
Future<TransactionJSonResponse> transfers(TransfersRef ref) async {
  return ref.watch(transactionRepositoryProvider).transfers();
}