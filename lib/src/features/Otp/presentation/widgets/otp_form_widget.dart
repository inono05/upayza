import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

class OtpFormWidget extends StatelessWidget with FormValidationMixin{
  OtpFormWidget({
    super.key,
    required this.pinController,
    required this.formKey,
  });

  final TextEditingController pinController;
  final focusNode = FocusNode();
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = context.colorScheme.primary;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      width: AppSize.containerSize / 2.2,
      height: AppSize.xsContainerSize * 2,
      textStyle: context.headlineLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.borderRadius),
        border: Border.all(color: context.colorScheme.primary),
      ),
    );
    return Form(
      key: formKey,
      child: Pinput(
        controller: pinController,
        focusNode: focusNode,
        length: 6,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(
          width: AppSize.halfSpacing,
        ),
        validator: (value) => otpValidator(value),
        // onClipboardFound: (value) {
        //   debugPrint('onClipboardFound: $value');
        //   pinController.setText(value);
        // },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          debugPrint('onCompleted: $pin');
        },
        onChanged: (value) {
          debugPrint('onChanged: $value');
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(AppSize.borderRadius),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: fillColor,
            borderRadius: BorderRadius.circular(AppSize.borderRadius),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: context.colorScheme.error),
        ),
      ),
    );
  }
}
