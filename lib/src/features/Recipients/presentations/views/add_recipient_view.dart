import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_form_request.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_json_response.dart';
import 'package:upayza/src/features/Recipients/presentations/controllers/recipient_controller.dart';
import 'package:upayza/src/features/Recipients/repository/recipient_repository.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

import '../../../../core/repository/operator_repository.dart';
import '../../../../shared/components/app_alert_dialog.dart';
import '../../../../shared/components/app_title.dart';
import '../../../../shared/components/forms/app_form_prefix_icon.dart';
import '../../../../shared/constants/app_sizes.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../../../Countries/repository/country_repository.dart';
import '../../../Transactions/presentation/controllers/state_controller.dart';
import '../../../Transactions/presentation/widgets/stepper_widgets/receiver_widgets/receiver_country_widget.dart';
import '../../../Transactions/presentation/widgets/transaction_operator_tile_widget.dart';

class AddRecipientView extends ConsumerWidget with FormValidationMixin {
  AddRecipientView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final numberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainAlignment = MainAxisAlignment.spaceBetween;
    final countriesAsyncValue = ref.watch(countriesProvider);
    final operatorsAsyncValue = ref.watch(operatorsProvider);

    final recipientState = ref.watch(recipientControllerProvider);
    final recipientNotifier = ref.read(recipientControllerProvider.notifier);

    final recipientCountry = ref.watch(recipientCountryProvider);
    final recipientOperator = ref.watch(recipientOperatorProvider);
    //get recipient information's to edit the recipient
    final recipient = ref.watch(recipientSelectedProvider);

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

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AppSize.spacing.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Iconsax.arrow_left).onTap(() {
                    GoRouter.of(context).pop();
                  }),
                  AppSize.spacing.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppTitle(title: "Recipients"),
                      AppTitle.h4(
                        title: recipient.isNull
                            ? "Create a new recipient"
                            : "Update Recipient",
                      )
                    ],
                  )
                ],
              ),
              AppSize.tripleSpacing.heightBox,
              Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AppFormField(
                      labelText: "Recipient Name",
                      controller: nameTextController..text = recipient?.firstName ?? "",
                      prefixIcon: const AppFormIcon(
                        icon: Icon(IconlyLight.add_user),
                      ),
                      validator: usernameValidator,
                      onChanged: (value) {},
                    ),
                    AppSize.doubleSpacing.heightBox,
                    AppFormField(
                      labelText: "Recipient Lastname",
                      controller: lastnameTextController..text = recipient?.firstName ?? "",
                      prefixIcon: const AppFormIcon(
                        icon: Icon(IconlyLight.add_user),
                      ),
                      validator: usernameValidator,
                      onChanged: (value) {},
                    ),
                    AppSize.doubleSpacing.heightBox,
                    AppFormField(
                      labelText: "Recipient E-mail Address",
                      controller: emailTextController..text = recipient?.email ?? "",
                      prefixIcon: AppFormIcon(icon: Assets.icons.email.svg()),
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                      onChanged: (value) {},
                    ),
                    AppSize.doubleSpacing.heightBox,
                    const AppTitle(title: "Recipient country"),
                    AppSize.doubleSpacing.heightBox,
                    SizedBox(
                      height: AppSize.containerSize / 1.2,
                      child: countriesAsyncValue.when(
                        data: (data) {
                          final countries = data.countries ?? [];
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: countries.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final country = countries.elementAt(index);
                              return ReceiverCountryWidget(
                                mainAlignment: mainAlignment,
                                country: country,
                              ).onTap(() {
                                ref
                                    .read(recipientCountryProvider.notifier)
                                    .update((state) => country);

                                ref
                                    .read(recipientOperatorProvider.notifier)
                                    .update((state) => null);
                              });
                            },
                          );
                        },
                        error: (err, s) => AppHelpers.showAlert(
                          context: context,
                          child: AppAlertDialog(
                            message: err.toString(),
                          ),
                        ),
                        loading: () => SpinKitRipple(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    AppSize.doubleSpacing.heightBox,
                    operatorsAsyncValue.when(
                      data: (data) {
                        final operators = data.operators;
                        return operators != null
                            ? TransactionOperatorTileWidget(
                                mainAlignment: mainAlignment,
                                operators: operators,
                              )
                            : const SizedBox.shrink();
                      },
                      error: (err, s) => AppHelpers.showAlert(
                        context: context,
                        child: AppAlertDialog(
                          message: err.toString(),
                        ),
                      ),
                      loading: () => SpinKitRipple(
                        color: context.colorScheme.primary,
                      ),
                    ),
                    AppSize.doubleSpacing.heightBox,
                    if (ref.watch(recipientCountryProvider) != null)
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
                        onChanged: (value) {},
                      ),
                    AppSize.doubleSpacing.heightBox,
                  ],
                ).expanded(),
              ),
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

                          await recipientNotifier.recipient(request);

                          ref
                              .read(recipientOperatorProvider.notifier)
                              .update((state) => null);
                          ref
                              .read(recipientCountryProvider.notifier)
                              .update((state) => null);

                          if (context.mounted) {
                            AppHelpers.notify(
                              context,
                              "Recipient has been added successfully.",
                            );
                            ref.invalidate(recipientsProvider);
                            GoRouter.of(context).pop();
                          }
                        }
                      },
              ),
              AppSize.spacing.heightBox,
            ],
          ).paddingSymmetric(
            horizontal: AppSize.padding,
            vertical: AppSize.padding,
          ),
        ),
      ),
    );
  }
}
