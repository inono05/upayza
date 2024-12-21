import 'dart:async';
import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Authentications/domains/auth_json_response.dart';
import 'package:upayza/src/features/Authentications/domains/reset_password_form_request.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/auth_controller.dart';
import 'package:upayza/src/features/Authentications/presentation/widgets/check_mail_for_password_forget_form_widget.dart';
import 'package:upayza/src/features/Authentications/presentation/widgets/new_password_create_form_widget.dart';

import 'package:upayza/src/shared/components/app_authentication_header.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class PasswordForgotView extends ConsumerWidget {
  PasswordForgotView({super.key});

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmedController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmailSend = ref.watch(isEmailCheckProvider);
    final authState = ref.watch(authControllerProvider);
    final authStateNotifier = ref.read(authControllerProvider.notifier);

    /* ref.listen(authControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });*/

    Future<AuthJSonResponse?> togglePasswordReset() async {
      final request = ResetPasswordRequest(
        code: codeController.text,
        password: newPasswordController.text,
      );
      final response = await authStateNotifier.resetPassword(request);
      return response;
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Iconsax.arrow_left)
                    .onTap(() => context.router.pop()),
                const AppAuthenticationHeader(
                  title: "Reset your password",
                  description: "Insert your E-Mail Address",
                ),
              ],
            ),
            AppSize.tripleSpacing.heightBox,
            (isEmailSend)
                ? NewPasswordCreateFormWidget(
                    formKey: formKey,
                    codeController: codeController,
                    newPasswordController: newPasswordController,
                    newPasswordConfirmedController:
                        newPasswordConfirmedController,
                  )
                : CheckMailForPasswordForgetFormWidget(
                    emailController: emailController,
                    formKey: formKey,
                  ),
            const Spacer(),
            AppButton(
              title: isEmailSend ? "Continue" : "Verify E-mail",
              isLoading: authState.isLoading,
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        if (isEmailSend) {
                          final result = await togglePasswordReset();
                          if (context.mounted) {
                            context.goNamed(
                              AppRoutes.authenticate.name,
                            );
                            AppHelpers.notify(
                              context,
                              result!.message!,
                            );
                          }
                        }
                        if (!isEmailSend) {
                          final otpResponse = await authStateNotifier
                              .verifyEmailForResetPassword(
                            emailController.text,
                          );

                          if (otpResponse.isNotNull) {
                            log("otpResponse: ${otpResponse.toString()}");
                            ref
                                .read(isEmailCheckProvider.notifier)
                                .update((state) => !state);
                            if (context.mounted) {
                              AppHelpers.notify(
                                context,
                                otpResponse!.message!,
                              );
                            }
                          }
                        }
                      }
                    },
            ),
            (AppSize.doubleSpacing * 1.5).heightBox,
          ],
        ).paddingSymmetric(horizontal: AppSize.padding),
      ),
    );
  }
}
