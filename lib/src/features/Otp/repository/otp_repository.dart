import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/core/models/json_response.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/features/Otp/domains/otp_form_request.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';

part 'otp_repository.g.dart';

abstract class IOtpRepository{
  Future<JSonResponse>emailVerify(OtpFormRequest request);
  Future<JSonResponse>resendOTP(EmailFormRequest request);
}


class OtpRepository extends BaseRepository implements IOtpRepository{
  OtpRepository(super.api);

  @override
  Future<JSonResponse> emailVerify(OtpFormRequest request) {
    return this.api.emailVerify(request);
  }

  @override
  Future<JSonResponse> resendOTP(EmailFormRequest request) {
    return this.api.resendOtpForEmailVerify(request);
  }
}

@Riverpod(keepAlive: true)
OtpRepository otpRepository (OtpRepositoryRef ref) {
  return OtpRepository(ref.watch(apiProvider));
}