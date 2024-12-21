import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/features/Otp/presentation/controllers/controller_otp.dart';
import 'package:upayza/src/shared/components/app_authentication_header.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class EmailVerificationView extends ConsumerWidget {
  EmailVerificationView({super.key});
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mail = ref.watch(emailProvider);
    final resendOTPState = ref.watch(otpControllerProvider);
    final resendOTPNotifier = ref.read(otpControllerProvider.notifier);

    ref.listen(otpControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSize.tripleSpacing.heightBox,
              AppSize.tripleSpacing.heightBox,
              const AppAuthenticationHeader(
                title: AppString.emailVerifyTitle,
                description: AppString.emailVerifyDescription,
              ),
              AppSize.tripleSpacing.heightBox,
              AppButton(
                title: AppString.emailVerifyBtnTitle,
                isLoading: resendOTPState.isLoading,
                onPressed: resendOTPState.isLoading
                    ? null
                    : () async {
                        log("message ==> $mail");
                        final response = await resendOTPNotifier.resendOTP(
                          request: EmailFormRequest(email: mail),
                        );
                        if (context.mounted) {
                          if (response != null) {
                            context.goNamed(
                              AppRoutes.otp.name,
                              pathParameters: {
                                'from': 'login',
                                'email': mail
                              },
                            );
                            AppHelpers.notify(context, response.message!);
                          }
                        }
                      },
              ),
              AppSize.doubleSpacing.heightBox,
            ],
          ).paddingSymmetric(horizontal: AppSize.padding),
        ),
      ),
    );
  }
}
