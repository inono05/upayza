import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/features/Transactions/domains/deposit_number_form_request.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

import '../models/deposit_number_json_response.dart';

part 'deposit_number_repository.g.dart';

abstract class IDepositNumberRepository{
  Future<DepositNumberJSonResponse> depositNumbers();
  Future<DepositNumberObjectJSonResponse> depositNumber(DepositNumberFormRequest request);
  Future<DepositNumberObjectJSonResponse> delete(int depositNumberId);
}

class DepositNumberRepository extends BaseRepository implements IDepositNumberRepository{
  DepositNumberRepository(super.api);

  @override
  Future<DepositNumberJSonResponse> depositNumbers() {
    return this.api.depositNumbers(AppUserPreferences().userId()!);
  }

  @override
  Future<DepositNumberObjectJSonResponse> depositNumber(DepositNumberFormRequest request) {
    return this.api.depositNumber(request);
  }

  @override
  Future<DepositNumberObjectJSonResponse> delete(int depositNumberId) {
    return this.api.depositNumberDeleted(depositNumberId);
  }
}

@Riverpod(keepAlive: true)
DepositNumberRepository depositNumberRepository (DepositNumberRepositoryRef ref) {
  return DepositNumberRepository(ref.watch(apiProvider));
}

@Riverpod(keepAlive: true)
Future<DepositNumberJSonResponse> depositNumbers (DepositNumbersRef ref) async {
  return ref.watch(depositNumberRepositoryProvider).depositNumbers();
}