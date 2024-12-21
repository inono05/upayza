import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/repository/deposit_number_repository.dart';
import 'package:upayza/src/features/Transactions/domains/deposit_number_form_request.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/deposit_controller.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/stepper_momo_widgets/deposit_modal_sheet_list_view.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

import '../../../../../core/models/deposit_number_json_response.dart';
import '../../../../../core/repository/operator_repository.dart';
import '../../../../../shared/components/app_alert_dialog.dart';
import '../../../../../shared/components/app_title.dart';
import '../../../../../shared/components/forms/app_form_field.dart';
import '../../../../../shared/components/forms/app_form_prefix_icon.dart';
import '../../../../../shared/constants/app_sizes.dart';
import '../../../../../shared/preferences/app_user_preferences.dart';
import '../../../../../shared/utils/app_helpers.dart';
import '../../../../Countries/presentation/controllers/country_controller.dart';
import '../../controllers/state_controller.dart';
import '../sender_country_operator_widget.dart';

class DepositModalSheet extends ConsumerWidget with FormValidationMixin {
  DepositModalSheet({
    super.key,
    required this.depositNumbers,
  });

  final List<DepositNumber> depositNumbers;

  final depositNumberTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final operatorsAsyncValue = ref.watch(operatorsProvider);
    final senderCountry = ref.watch(userCountryProvider);
    final senderCountryFormatted = ref.watch(senderFormatCountryProvider);
    final senderOperator = ref.watch(senderOperatorProvider);

    final depositNumberState = ref.watch(depositControllerProvider);
    final depositNumberNotifier = ref.read(depositControllerProvider.notifier);
    final isDepositNumber = ref.watch(isDepositNumberProvider);

    /**TODO fix bug when adding new Deposit Number
     * now listen is comment
     * ref.listen(depositControllerProvider, (prev, next) {
        return next.showAlertOnError(context);
        });
     */
    ref.listen(depositControllerProvider, (prev, next) {
      return next.showAlertOnError(context);
    });

    return (depositNumbers.isNotEmpty && !isDepositNumber)
        ? SizedBox(
            height: AppSize.xlContainerSize * 1.4,
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.containerSize / 2.5,
                  child: FittedBox(
                    child: FloatingActionButton.extended(
                      backgroundColor: context.colorScheme.primary,
                      tooltip: "Click Here to create a deposit Number",
                      onPressed: () {
                        ref
                            .read(isDepositNumberProvider.notifier)
                            .update((state) => !isDepositNumber);
                      },
                      label: AppTitle(
                        title: "New Deposit Number",
                        color: context.surface,
                      ),
                      icon: Icon(
                        Iconsax.mobile,
                        color: context.surface,
                      ),
                    ),
                  ),
                ).alignAtTopRight().paddingSymmetric(
                      horizontal: AppSize.halfPadding,
                      vertical: AppSize.halfPadding,
                    ),
                Row(
                  children: [
                    const Icon(IconlyLight.document),
                    AppSize.halfPadding.widthBox,
                    const AppTitle.h5(title: "Saved Deposit Numbers"),
                  ],
                ).paddingOnly(left: AppSize.halfPadding),
                DepositModalSheetListView(
                  depositNumbers: depositNumbers,
                  depositNumberState: depositNumberState,
                  depositNumberNotifier: depositNumberNotifier,
                ).expanded(),
              ],
            ),
          )
        //Widget modal form for deposit number
        : SizedBox(
            height: AppSize.xlContainerSize * 1.4,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  AppSize.doubleSpacing.heightBox,
                  operatorsAsyncValue.when(
                    data: (data) {
                      final operators = data.operators;
                      return operators != null
                          ? SenderCountryOperatorWidget(
                              mainAlignment: MainAxisAlignment.spaceBetween,
                              operators: operators,
                              userCountryId: AppUserPreferences().countryId(),
                            ).paddingSymmetric(
                              horizontal: AppSize.padding,
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
                  AppSize.tripleSpacing.heightBox,
                  AppFormField(
                    labelText: "deposit Number",
                    controller: depositNumberTextController,
                    prefixIcon: AppFormIcon(
                      countryCode: senderCountry!.countryCode!,
                    ),
                    suffixIcon: const AppFormIcon(
                      icon: Icon(Iconsax.mobile),
                      isRight: false,
                    ),
                    keyboardType: TextInputType.number,
                    validator: inputValidator,
                    inputFormatters: [
                      LibPhonenumberTextFormatter(
                        country: senderCountryFormatted!,
                        phoneNumberFormat: PhoneNumberFormat.international,
                        phoneNumberType: PhoneNumberType.mobile,
                      )
                    ],
                    onChanged: (value) {
                      ref
                          .read(senderNumberProvider.notifier)
                          .update((state) => value);
                    },
                  ).paddingSymmetric(horizontal: AppSize.doublePadding),

                  //Modal Buttons
                  Column(
                    children: [
                      AppSize.padding.heightBox,
                      AppButton(
                        title: "Save Deposit Number",
                        isLoading: depositNumberState.isLoading,
                        onPressed: depositNumberState.isLoading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  final number = "${senderCountry.countryCode}${depositNumberTextController.text}".removeAllWhitespace;

                                  final request = DepositNumberFormRequest(
                                    userId: AppUserPreferences().userId(),
                                    operatorId: senderOperator?.id,
                                    value: number,
                                  );
                                  final response = await depositNumberNotifier
                                      .depositNumber(request);
                                  final numberProvider =
                                      senderDepositNumberProvider;

                                  if (context.mounted) {
                                    ref
                                        .read(isDepositNumberProvider.notifier)
                                        .update((state) => !isDepositNumber);

                                    ref.read(numberProvider.notifier).update(
                                        (state) => response?.depositNumber);
                                    ref.invalidate(depositNumbersProvider);
                                    GoRouter.of(context).pop();

                                    AppHelpers.notify(
                                      context,
                                      "Deposit Number created successfully",
                                    );
                                  }
                                }
                              },
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(isDepositNumberProvider.notifier)
                              .update((state) => !isDepositNumber);
                        },
                        child: const Row(
                          children: [
                            Icon(Iconsax.arrow_left),
                            AppTitle(title: "Back")
                          ],
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                    vertical: AppSize.padding,
                    horizontal: AppSize.padding,
                  ),
                ],
              ),
            ),
          );
  }
}

class OperatorBadgeWidget extends StatelessWidget {
  const OperatorBadgeWidget({
    super.key,
    required this.depositNumberLabel,
    required this.depositNumberCode,
  });

  final String? depositNumberLabel;
  final String? depositNumberCode;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius / 2,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: context.colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
          color: context.colorScheme.surface,
        ),
        child: AppTitle.h6(
          title: "$depositNumberLabel $depositNumberCode",
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ).paddingSymmetric(
        horizontal: AppSize.padding / 2,
      ),
    ).paddingSymmetric(
      horizontal: AppSize.padding,
      vertical: AppSize.halfPadding / 3,
    );
  }
}

class DepositNumberActionWidget extends ConsumerWidget {
  const DepositNumberActionWidget({
    super.key,
    required this.backgroundColor,
    required this.actionIcon,
    required this.action,
    required this.depositNumbers,
    required this.valueState,
    required this.controller,
    required this.depositNumber,
  });

  final Color backgroundColor;
  final IconData actionIcon;
  final String action;
  final List<DepositNumber> depositNumbers;
  final DepositNumber depositNumber;
  final AsyncValue valueState;
  final DepositController controller;
  @override
  Widget build(BuildContext context, ref) {
    return Material(
      elevation: 2.5,
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius / 2,
      ),
      color: Colors.white,
      child: SizedBox(
        height: AppSize.xsContainerSize * 1.4,
        width: AppSize.xsContainerSize * 1.4,
        child: IconButton(
          icon: (valueState.isLoading && action.contains('delete'))
              ? SpinKitRipple(
                  color: backgroundColor,
                  size: AppSize.iconSize / 2,
                )
              : Icon(
                  actionIcon,
                  color: backgroundColor,
                  size: AppSize.iconSize,
                ),
          onPressed: valueState.isLoading
              ? null
              : () async {
                  log("message");
                  if (action.contains('delete')) {
                    depositNumbers.remove(depositNumber);
                    ref
                        .read(senderDepositNumberProvider.notifier)
                        .update((state) => null);
                    await controller.deleteDepositNumber(depositNumber.id!);
                    AppHelpers.resetAllProviders(ref);
                    GoRouter.of(context).pop();
                  }
                },
        ).alignAtCenter(),
      ),
    );
  }
}
