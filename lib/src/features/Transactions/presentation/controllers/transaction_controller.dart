import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';
import 'package:upayza/src/features/Transactions/domains/transfer_form_request.dart';
import 'package:upayza/src/features/Transactions/repository/transaction_repository.dart';
part 'transaction_controller.g.dart';

@riverpod
class TransactionController extends _$TransactionController {
  @override
  FutureOr<TransactionObjectJSonResponse?> build() async {
    return null;
  }

  Future<TransactionObjectJSonResponse?> transfer(TransferFormRequest request) async{
    state = const AsyncLoading();
    final transactionRepository = ref.watch(transactionRepositoryProvider);
    state = await AsyncValue.guard(() => transactionRepository.transfer(request));
    return state.valueOrNull;
  }
}
