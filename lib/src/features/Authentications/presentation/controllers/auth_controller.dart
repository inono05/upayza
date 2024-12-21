import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/features/Authentications/domains/auth_json_response.dart';
import 'package:upayza/src/features/Authentications/domains/reset_password_form_request.dart';
import 'package:upayza/src/features/Authentications/domains/user_register_form_request.dart';
import 'package:upayza/src/features/Authentications/repositories/auth_repository.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthJSonResponse?> build() async {
    return null;
  }

  Future<AuthJSonResponse?> login(dynamic request) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.login(
        request: request,
      ),
    );
    if (state.hasValue) {
      AppUserPreferences().saveToken(state.value!.token!);
      AppUserPreferences().saveUserID(state.value!.user!.id!);
      AppUserPreferences().saveCountryId(state.value!.user!.countryId!);
      AppUserPreferences().storeUser(state.value!.user!);
      log("token ===> ${AppUserPreferences().token()}");
    }
    return state.value;
  }

  Future<AuthJSonResponse?> register(UserRegisterFormRequest request) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.register(
        request: request,
      ),
    );
    if (state.hasValue) {
      AppUserPreferences().saveToken(state.value!.token!);
      AppUserPreferences().saveUserID(state.value!.user!.id!);
      AppUserPreferences().saveCountryId(state.value!.user!.countryId!);
      AppUserPreferences().storeUser(state.value!.user!);
      log("token ===> ${AppUserPreferences().token()}");
    }
    return state.value;
  }

  Future<AuthJSonResponse?> verifyEmailForResetPassword(String email) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.verifyEmailForResetPassword(
        request: EmailFormRequest(email: email),
      ),
    );
    return state.value;
  }

  Future<AuthJSonResponse?> resetPassword(ResetPasswordRequest request) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.resetPassword(request: request),
    );
    return state.value;
  }

  Future<AuthJSonResponse?> logout() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.logout());
    await AppUserPreferences().clear();
    return state.value;
  }
}
