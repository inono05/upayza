import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/features/Otp/domains/otp_form_request.dart';
import 'package:upayza/src/features/Otp/presentation/controllers/controller_otp.dart';
import 'package:upayza/src/features/Otp/presentation/controllers/otp_count_down.dart';
import 'package:upayza/src/features/Otp/presentation/widgets/otp_form_widget.dart';
import 'package:upayza/src/shared/components/app_authentication_header.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';


class OtpView extends ConsumerWidget {
  OtpView({
    super.key,
    required this.from,
    required this.email,
  });
  final String from;
  final String email;

  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(countdownProvider);
    final counterPadLeft = counter.toString().padLeft(2, '0');
    final verifyOTPState = ref.watch(otpControllerProvider);
    final verifyOTPNotifier = ref.read(otpControllerProvider.notifier);
    final resendOTPNotifier = ref.read(otpControllerProvider.notifier);

    ref.listen(otpControllerProvider, (previous, next) {
      if (next.hasError) {
        ref.read(hasErrorProvider.notifier).update((state) => next.hasError);
      }
      return next.showAlertOnError(context);
    });

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSize.spacing.heightBox,
              const AppAuthenticationHeader(
                title: "OTP Verification",
                description: AppString.otpDescription,
              ),
              AppSize.tripleSpacing.heightBox,
              OtpFormWidget(
                formKey: formKey,
                pinController: pinController,
              ),
              AppSize.tripleSpacing.heightBox,
              AppSize.tripleSpacing.heightBox,
              RichText(
                text: TextSpan(
                  text: "Remaining time: ",
                  style: context.headlineLarge,
                  children: [
                    TextSpan(
                      text: "00 : $counterPadLeft",
                      style: context.displaySmall?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              AppSize.halfSpacing.heightBox,
              (counter == 30)
                  ? RichText(
                      text: TextSpan(
                        text: "Didn't receive code? ",
                        style: context.headlineLarge,
                        children: [
                          TextSpan(
                            text: " Resend",
                            style: context.displaySmall?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final response =
                                    await resendOTPNotifier.resendOTP(
                                  request: EmailFormRequest(
                                    email: email,
                                  ),
                                );
                                if (context.mounted && response != null) {
                                  final counterNotifier = countdownProvider;
                                  ref
                                      .read(counterNotifier.notifier)
                                      .startCountdown();
                                  AppHelpers.notify(context, response.message!);
                                }
                              },
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const Spacer(),
              AppButton(
                title: T(context).check,
                isLoading: verifyOTPState.isLoading,
                onPressed: verifyOTPState.isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          final response = await verifyOTPNotifier.emailVerify(
                            request: OtpFormRequest(
                              otp: pinController.text,
                              email: ref.watch(emailProvider),
                            ),
                          );
                          if (context.mounted && response != null) {
                            final isOTPExpired = response.message!.contains(
                              "expired",
                            );
                            AppHelpers.notify(
                              context,
                              response.message!,
                              isSuccess: (isOTPExpired) ? false : true,
                            );
                            (isOTPExpired)
                                ? pinController.clear()
                                : context.goNamed(AppRoutes.dashboard.name);
                          }
                        }
                      },
              ),
              AppSize.tripleSpacing.heightBox,
              AppSize.doubleSpacing.heightBox,
            ],
          ),
        ).paddingSymmetric(horizontal: AppSize.padding),
      ),
    );
  }
}
