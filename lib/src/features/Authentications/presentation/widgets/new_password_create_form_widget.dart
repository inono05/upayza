import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

class NewPasswordCreateFormWidget extends ConsumerWidget
    with FormValidationMixin {
  NewPasswordCreateFormWidget({
    super.key,
    required this.codeController,
    required this.newPasswordController,
    required this.newPasswordConfirmedController,
    required this.formKey,
  });
  final TextEditingController codeController;
  final TextEditingController newPasswordController;
  final TextEditingController newPasswordConfirmedController;
  final codeFocusNode = FocusNode();

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHide = ref.watch(passwordVisibleProvider);
    final isConfirmedHide = ref.watch(confirmPwdVisibleProvider);
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFormField(
            labelText: "Code",
            focusNode: codeFocusNode,
            controller: codeController,
            prefixIcon: AppFormIcon(
              icon: Assets.icons.passwordLock.svg(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => otpValidator(value),
          ),
          AppFormField(
            labelText: "New Password",
            isPassword: isHide,
            controller: newPasswordController,
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
            labelText: "Confirmed New Password",
            isPassword: isConfirmedHide,
            controller: newPasswordConfirmedController,
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
              newPasswordController.text,
            ),
          ),
        ],
      ),
    );
  }
}
