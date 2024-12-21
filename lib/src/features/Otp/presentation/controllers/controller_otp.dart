import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/core/models/json_response.dart';
import 'package:upayza/src/features/Otp/domains/otp_form_request.dart';
import 'package:upayza/src/features/Otp/repository/otp_repository.dart';

part 'controller_otp.g.dart';

@riverpod
class OtpController extends _$OtpController {
  @override
  FutureOr<JSonResponse?> build() async {
    return null;
  }

  Future<JSonResponse?> emailVerify({required OtpFormRequest request}) async {
    final otpRepository = ref.watch(otpRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => otpRepository.emailVerify(request));
    return state.value;
  }

  Future<JSonResponse?> resendOTP({required EmailFormRequest request}) async {
    final otpRepository = ref.watch(otpRepositoryProvider);
    state = const AsyncLoading();
    log(request.toString());
    state = await AsyncValue.guard(
      () => otpRepository.resendOTP(request),
    );
    return state.value;
  }
}
