import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

class CheckMailForPasswordForgetFormWidget extends ConsumerWidget
    with FormValidationMixin {
  CheckMailForPasswordForgetFormWidget({
    super.key,
    required this.emailController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, ref) {
    return Form(
      key: formKey,
      child: AppFormField(
        labelText: "E-mail Address",
        controller: emailController,
        prefixIcon: AppFormIcon(
          icon: Assets.icons.email.svg(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: emailValidator,
        onChanged: (value) {
          ref.read(emailProvider.notifier).update((state) => value!);
        },
      ),
    );
  }
}
