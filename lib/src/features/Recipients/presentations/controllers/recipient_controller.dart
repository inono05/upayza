import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_form_request.dart';
import 'package:upayza/src/features/Recipients/repository/recipient_repository.dart';

import '../../domain/recipient_json_response.dart';

part 'recipient_controller.g.dart';

@riverpod
class RecipientController extends _$RecipientController {
  @override
  FutureOr<RecipientObjectJSonResponse?> build() async {
    return null;
  }

  Future<RecipientObjectJSonResponse?> recipient(RecipientFormRequest request) async {
    final recipientRepository = ref.watch(recipientRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => recipientRepository.recipient(
        request,
      ),
    );
    return state.value;
  }
}
