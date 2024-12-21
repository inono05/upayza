import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Authentications/domains/user_login_form_request.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/auth_controller.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

import '../app_authentication_widget.dart';

class LoginTabWidget extends ConsumerWidget with FormValidationMixin {
  LoginTabWidget({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHide = ref.watch(passwordVisibleProvider);
    final isPhone = ref.watch(usePhoneProvider);
    ref.listen(authControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });
    final loginState = ref.watch(authControllerProvider);
    final loginStateReader = ref.read(authControllerProvider.notifier);
    return Form(
      key: formKey,
      child: ListView(
        children: [
          AppFormField(
            labelText: (isPhone) ? "Phone Number".capitalizeFirst : "E-mail Address",
            controller: (isPhone) ? phoneController : emailController,
            prefixIcon: AppFormIcon(
              icon: (isPhone)
                  ? Assets.icons.smartPhone.svg()
                  : Assets.icons.email.svg(),
            ),
            keyboardType:
                (isPhone) ? TextInputType.phone : TextInputType.emailAddress,
            validator: (value) {
              return (isPhone) ? mobileValidator(value) : emailValidator(value);
            },
          ),
          AppFormField(
            labelText: "Password",
            isPassword: isHide,
            controller: passwordController,
            prefixIcon: AppFormIcon(
              icon: Assets.icons.key.svg(),
            ),
            suffixIcon: IconButton(
              icon: Icon(isHide ? IconlyBroken.hide : IconlyBroken.show),
              onPressed: () {
                ref
                    .read(passwordVisibleProvider.notifier)
                    .update((state) => !state);
              },
            ),
            validator: (value) => passwordValidator(value),
          ),
          const AppTitle(title: "Forgot Password")
              .alignAtCenterRight()
              .onTap(() {
            ref.invalidate(passwordVisibleProvider);
            ref.invalidate(confirmPwdVisibleProvider);
            ref.invalidate(isEmailCheckProvider);
            context.router.pushNamed(AppRoutes.forgotPassword.name);
          }).paddingSymmetric(vertical: AppSize.doublePadding),
          AppAuthenticationButtonWidget(
            title: "Continue with Google",
            icon: Assets.icons.google.svg(),
          ),
          AppAuthenticationButtonWidget(
            title: (isPhone)
                ? AppString.signInWithMail
                : AppString.signInWithPhoneNumber,
            icon: Assets.icons.smartPhone.svg(),
          ).onTap(() {
            ref.read(usePhoneProvider.notifier).update((state) => !state);
          }),
          AppSize.tripleSpacing.heightBox,
          AppSize.tripleSpacing.heightBox,
          AppButton(
            title: "Connexion",
            isLoading: loginState.isLoading,
            onPressed: loginState.isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      final request = (isPhone)
                          ? UserLoginWithPhoneFormRequest(
                              phone: phoneController.text,
                              password: passwordController.text,
                            )
                          : UserLoginWithEmailFormRequest(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      log(request.toString());
                      final response = await loginStateReader.login(request);
                      if (context.mounted && response != null) {
                        final isEmailVerified =
                            response.user!.emailVerifiedAt != null;
                        ref
                            .read(emailProvider.notifier)
                            .update((state) => response.user!.email!);

                        if (context.mounted && isEmailVerified) {
                          context.goNamed(AppRoutes.dashboard.name);
                          AppHelpers.notify(context, response.message!);
                        }

                        if (context.mounted && !isEmailVerified) {
                          context.goNamed(AppRoutes.emailVerify.name);
                          AppHelpers.notify(context, response.message!);
                        }
                      }
                    }
                  },
          ),
          AppSize.doubleSpacing.heightBox,
        ],
      ),
    );
  }
}
