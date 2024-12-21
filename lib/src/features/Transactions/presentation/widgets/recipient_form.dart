import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../shared/components/buttons/app_button.dart';
import '../../../../shared/components/forms/app_form_field.dart';
import '../../../../shared/components/forms/app_form_prefix_icon.dart';
import '../../../../shared/constants/app_sizes.dart';
import '../../../../shared/preferences/app_user_preferences.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../../../Recipients/domain/recipient_form_request.dart';
import '../../../Recipients/presentations/controllers/recipient_controller.dart';
import '../../../Recipients/repository/recipient_repository.dart';
import '../controllers/state_controller.dart';

class RecipientForm extends ConsumerWidget with FormValidationMixin {
  RecipientForm({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final numberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context, ref) {
    final recipientState = ref.watch(recipientControllerProvider);
    final recipientNotifier = ref.read(recipientControllerProvider.notifier);

    final recipientCountry = ref.watch(recipientCountryProvider);
    final recipientOperator = ref.watch(recipientOperatorProvider);

    /**TODO fix bug when adding new recipient Number
     * now listen is comment
     * ref.listen(recipientControllerProvider, (previous, next) {
        ref.read(hasErrorProvider.notifier).update((state) => next.hasError);
        return next.showAlertOnError(context);
        });
     */
    ref.listen(recipientControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });

    return Form(
      key: formKey,
      child: Column(
        children: [
          AppSize.doubleSpacing.heightBox,
          AppFormField(
            labelText: "Recipient Name",
            controller: nameTextController,
            prefixIcon: const AppFormIcon(
              icon: Icon(IconlyLight.add_user),
            ),
            validator: usernameValidator,
            onChanged: (value) {
              ref.read(recipientNameProvider.notifier).update((state) => value);
            },
          ),
          AppSize.doubleSpacing.heightBox,
          AppFormField(
            labelText: "Recipient Lastname",
            controller: lastnameTextController,
            prefixIcon: const AppFormIcon(
              icon: Icon(IconlyLight.add_user),
            ),
            validator: usernameValidator,
            onChanged: (value) {},
          ),
          AppSize.doubleSpacing.heightBox,
          AppFormField(
            labelText: "Recipient E-mail Address",
            controller: emailTextController,
            prefixIcon: AppFormIcon(icon: Assets.icons.email.svg()),
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
            onChanged: (value) {},
          ),
          AppSize.doubleSpacing.heightBox,
          AppFormField(
            labelText: "Recipient Number",
            controller: numberTextController,
            suffixIcon: AppFormIcon(
              icon: Assets.icons.smartPhone.svg(),
              isRight: false,
            ),
            prefixIcon: AppFormIcon(
              countryCode: recipientCountry?.countryCode!,
            ),
            keyboardType: TextInputType.phone,
            validator: mobileValidator,
            inputFormatters: [
              LibPhonenumberTextFormatter(
                country: ref.watch(recipientFormatCountryProvider)!,
                phoneNumberFormat: PhoneNumberFormat.international,
                phoneNumberType: PhoneNumberType.mobile,
              )
            ],
            onChanged: (value) {
              ref
                  .read(recipientNumberProvider.notifier)
                  .update((state) => value);
            },
          ),
          Row(
            children: [
              Icon(
                Iconsax.warning_25,
                color: context.colorScheme.error,
              ),
              AppSize.spacing.widthBox,
              AppTitle.h5(
                title: "Your must enter a ${recipientOperator?.label!} number",
                color: context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          AppSize.tripleSpacing.heightBox,
          AppButton(
            title: "Save recipient",
            isLoading: recipientState.isLoading,
            onPressed: recipientState.isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      final number = numberTextController.text;
                      final request = RecipientFormRequest(
                        userId: AppUserPreferences().userId(),
                        operatorId: recipientOperator?.id,
                        number: number,
                        email: emailTextController.text,
                        firstName: nameTextController.text,
                        lastName: lastnameTextController.text,
                      );

                      final response = await recipientNotifier
                          .recipient(request);

                      if (context.mounted) {
                        ref
                            .read(recipientSelectedProvider.notifier)
                            .update((state) => response?.recipient);

                        ref.invalidate(recipientsProvider);

                        (context).pop();
                        AppHelpers.notify(
                          context,
                          "Recipient has been added successfully.",
                        );
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}
