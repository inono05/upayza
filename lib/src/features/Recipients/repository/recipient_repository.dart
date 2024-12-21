import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_form_request.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

import '../domain/recipient_json_response.dart';

part 'recipient_repository.g.dart';

abstract class IRecipientRepository{
  Future<RecipientJSonResponse> recipients();
  Future<RecipientObjectJSonResponse> recipient(RecipientFormRequest request);
}

class RecipientRepository extends BaseRepository implements IRecipientRepository{
  RecipientRepository(super.api);

  @override
  Future<RecipientObjectJSonResponse> recipient(RecipientFormRequest request) {
    return this.api.recipient(request);
  }

  @override
  Future<RecipientJSonResponse> recipients() {
    return this.api.recipients(AppUserPreferences().userId()!);
  }
}

@Riverpod(keepAlive: true)
RecipientRepository recipientRepository (RecipientRepositoryRef ref) {
  return RecipientRepository(ref.watch(apiProvider));
}

@Riverpod(keepAlive: true)
Future<RecipientJSonResponse> recipients(RecipientsRef ref) async {
  return ref.watch(recipientRepositoryProvider).recipients();
}