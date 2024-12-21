import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Authentications/domains/user_register_form_request.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/auth_controller.dart';
import 'package:upayza/src/features/Countries/presentation/controllers/country_controller.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';
import '../../../../../shared/constants/app_string.dart';
import '../app_authentication_widget.dart';

class RegisterTabWidget extends ConsumerWidget with FormValidationMixin {
  RegisterTabWidget({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmedController = TextEditingController();
  final phoneController = TextEditingController();
  final firstnameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHide = ref.watch(passwordVisibleProvider);
    final checkBoxValue = ref.watch(registerCheckboxStateProvider);
    final isConfirmedHide = ref.watch(confirmPwdVisibleProvider);
    final isPhone = ref.watch(usePhoneProvider);
    final myCountry = ref.watch(countryProvider);
    final countryController = TextEditingController(text: myCountry?.label ?? "");

    final registerState = ref.watch(authControllerProvider);
    final registerStateReader = ref.read(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });

    return Form(
      key: formKey,
      child: ListView(
        children: [
          AppFormField(
            labelText: "Select your country",
            controller: countryController,
            prefixIcon: const AppFormIcon(
              icon: Icon(Iconsax.global_edit),
            ),
            readOnly: true,
            onTap: () => AppHelpers.showCountryDialog(context),
          ),
          AppFormField(
            labelText: "Username",
            controller: firstnameController,
            prefixIcon: const AppFormIcon(
              icon: Icon(Iconsax.user_add),
            ),
            onChanged: (value) {},
            validator: (value) => usernameValidator(value),
          ),
          AppFormField(
            labelText: (isPhone) ? "Phone Number" : "E-mail Address",
            controller: (isPhone) ? phoneController : emailController,
            validator: (value) => (isPhone)
                ? mobileValidator(value)
                : emailValidator(value),
            prefixIcon: AppFormIcon(
              icon: (isPhone)
                  ? Assets.icons.smartPhone.svg()
                  : Assets.icons.email.svg(),
            ),
            keyboardType: (isPhone)
                ? TextInputType.phone
                : TextInputType.emailAddress,
          ),
          AppFormField(
            labelText: "Password",
            isPassword: isHide,
            controller: passwordController,
            prefixIcon: AppFormIcon(
              icon: Assets.icons.key.svg(),
            ),
            suffixIcon: Icon(
              isHide ? IconlyBroken.hide : IconlyBroken.show,
            ).onTap(() {
              ref.read(passwordVisibleProvider.notifier).update((state) => !state);
            }),
            validator: (value) => passwordValidator(value),
          ),
          AppFormField(
            labelText: "Confirmed Password",
            isPassword: isConfirmedHide,
            controller: passwordConfirmedController,
            prefixIcon: AppFormIcon(
              icon: Assets.icons.key.svg(),
            ),
            suffixIcon: Icon(
              isConfirmedHide ? IconlyBroken.hide : IconlyBroken.show,
            ).onTap(() {
              ref.read(confirmPwdVisibleProvider.notifier).update((state) => !state);
            }),
            validator: (value) => passwordConfirmationValidator(
              value,
              passwordController.text,
            ),
          ),
          CheckboxListTile(
            onChanged: (value) {
              final checkboxProvider = registerCheckboxStateProvider;
              ref.read(checkboxProvider.notifier).isChecked();
            },
            value: checkBoxValue,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text.rich(
              TextSpan(
                text: "By signing up you agree to our ",
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  )
                ],
                style: context.textTheme.headlineSmall,
              ),
            ),
          )
              .alignAtCenterRight()
              .onTap(() {})
              .paddingSymmetric(vertical: AppSize.doublePadding),
          AppAuthenticationButtonWidget(
            title: "Continue with Google",
            icon: Assets.icons.google.svg(),
          ),
          AppAuthenticationButtonWidget(
            title: (isPhone) ? AppString.signUpWithMail : AppString.signUpWithPhoneNumber,
            icon: Assets.icons.smartPhone.svg(),
          ).onTap(() {
            ref.read(usePhoneProvider.notifier).update((state) => !state);
          }),
          AppSize.tripleSpacing.heightBox,
          AppSize.tripleSpacing.heightBox,
          AppButton(
            title: "Register",
            isLoading: registerState.isLoading,
            onPressed: registerState.isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      final request = UserRegisterFormRequest(
                        countryId: myCountry?.id,
                        email: emailController.text,
                        password: passwordController.text,
                        firstName: firstnameController.text,
                      );
                      log('${request.toJson()}');
                      final response = await registerStateReader.register(
                        request,
                      );
                      if (context.mounted && response != null) {
                        ref
                            .read(emailProvider.notifier)
                            .update((state) => response.user!.email!);

                        context.goNamed(
                          AppRoutes.otp.name,
                          pathParameters: {
                            'from': 'register',
                            'email': ref.watch(emailProvider),
                          },
                        );
                        AppHelpers.notify(context, response.message!);
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
