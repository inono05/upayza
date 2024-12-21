import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/deposit_number_json_response.dart';
import 'package:upayza/src/core/repository/deposit_number_repository.dart';
import 'package:upayza/src/features/Transactions/domains/deposit_number_form_request.dart';

part 'deposit_controller.g.dart';

@riverpod
class DepositController extends _$DepositController {
  @override
  FutureOr<DepositNumberObjectJSonResponse?> build() async {
    return null;
  }

  Future<DepositNumberObjectJSonResponse?> depositNumber(
      DepositNumberFormRequest request) async {
    final depositNumberRepository = ref.watch(depositNumberRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => depositNumberRepository.depositNumber(request),
    );
    return state.value;
  }

  Future<DepositNumberObjectJSonResponse?> deleteDepositNumber(
      int depositNumberId) async {
    final depositNumberRepository = ref.watch(depositNumberRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => depositNumberRepository.delete(depositNumberId));

    return state.valueOrNull;
  }
}
