import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/features/Authentications/domains/auth_json_response.dart';
import 'package:upayza/src/features/Authentications/domains/reset_password_form_request.dart';
import 'package:upayza/src/features/Authentications/domains/user_register_form_request.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';

part 'auth_repository.g.dart';

abstract class IAuthRepository {
  Future<AuthJSonResponse> login({required dynamic request});
  Future<AuthJSonResponse> register({required UserRegisterFormRequest request});
  Future<AuthJSonResponse> verifyEmailForResetPassword(
      {required EmailFormRequest request});
  Future<AuthJSonResponse> resetPassword(
      {required ResetPasswordRequest request});
  Future<AuthJSonResponse> logout();
}

class AuthRepository extends BaseRepository implements IAuthRepository {
  AuthRepository(super.api);

  @override
  Future<AuthJSonResponse> login({required dynamic request}) {
    return this.api.login(request);
  }

  @override
  Future<AuthJSonResponse> register({
    required UserRegisterFormRequest request,
  }) {
    return this.api.register(request);
  }

  @override
  Future<AuthJSonResponse> verifyEmailForResetPassword({
    required EmailFormRequest request,
  }) {
    return this.api.verifyEmailForResetPassword(request);
  }

  @override
  Future<AuthJSonResponse> resetPassword(
      {required ResetPasswordRequest request}) {
    return this.api.resetPassword(request);
  }

  @override
  Future<AuthJSonResponse> logout() {
    return this.api.logout();
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(apiProvider));
}
