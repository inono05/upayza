import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/repository/operator_repository.dart';
import 'package:upayza/src/features/Countries/repository/country_repository.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/receiver_filter_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/stepper_widgets/receiver_widgets/receiver_country_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/transaction_operator_tile_widget.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../shared/components/fees_details_container.dart';

class ReceiverWidget extends ConsumerWidget with FormValidationMixin {
  ReceiverWidget({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  final recipientNameTextController = TextEditingController();
  final recipientNumberTextController = TextEditingController();
  final searchTextController = TextEditingController();

  final subtitle = "Choose the recipient country";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainAlignment = MainAxisAlignment.spaceBetween;
    final countriesAsyncValue = ref.watch(countriesProvider);
    final operatorsAsyncValue = ref.watch(operatorsProvider);
    final recipientCountry = ref.watch(recipientCountryProvider);
    final recipientOperator = ref.watch(recipientOperatorProvider);
    final recipientNumber = ref.watch(recipientNumberProvider);
    final recipientName = ref.watch(recipientNameProvider);
    final chosenRecipient = ref.watch(recipientSelectedProvider);
    final amountToReceiveTextController = TextEditingController(
      text: ref.watch(senderAmountProvider).toString(),
    );

    ref.listen(recipientSelectedProvider, (prev, next) {
      recipientNameTextController.text = next!.firstName!;
      recipientNumberTextController.text = next.number!;
    });

    ref.listen(recipientNameProvider, (prev, next) {
      recipientNameTextController.text = next!;
    });

    ref.listen(recipientNumberProvider, (prev, next) {
      recipientNumberTextController.text = next!;
    });

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /**
           * Widget for recipient country
           */

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle.h5(title: "Recipient country".capitalize),
              Row(
                children: [
                  const Icon(
                    IconlyLight.info_circle,
                    size: AppSize.iconSize / 1.7,
                  ),
                  AppSize.halfPadding.widthBox,
                  AppTitle.h5(
                    title: subtitle.capitalize,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              AppSize.spacing.heightBox,
              AppFormField(
                labelText: "Search Recipient country",
                controller: searchTextController,
                prefixIcon: const AppFormIcon(
                  icon: Icon(Iconsax.search_normal),
                ),
                onChanged: (value) {
                  log(value!);
                  ref.read(filterCountryProvider.notifier).state = value;
                },
                onEditingComplete: () {},
              ),
              AppSize.spacing.heightBox,
              SizedBox(
                height: AppSize.containerSize / 1.19,
                child: countriesAsyncValue.when(
                  data: (data) {
                    final countries = ref.watch(recipientCountriesProvider);
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
            ],
          ),

          /**
           * Column widget for recipient
           * money operator depending on his country
           */
          if (recipientCountry != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSize.tripleSpacing.heightBox,
                AppTitle.h5(title: "Choose Mobile Money Operator".capitalize),
                Row(
                  children: [
                    const Icon(
                      IconlyLight.info_circle,
                      size: AppSize.iconSize / 1.7,
                    ),
                    AppSize.halfPadding.widthBox,
                    AppTitle.h5(
                      title: "Recipient Operator Information's".capitalize,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                AppSize.halfSpacing.heightBox,
                operatorsAsyncValue.when(
                  data: (data) {
                    final operators = data.operators;
                    return TransactionOperatorTileWidget(
                      mainAlignment: mainAlignment,
                      operators: operators!,
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
                AppSize.tripleSpacing.heightBox,
              ],
            ),

          /**
           * Column widget for recipient
           * mobile number & name
           */
          if (recipientOperator != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitle.h5(title: "Recipient Information's".capitalize),
                Row(
                  children: [
                    const Icon(
                      IconlyLight.info_circle,
                      size: AppSize.iconSize / 1.7,
                    ),
                    AppSize.halfPadding.widthBox,
                    AppTitle.h5(
                      title: subtitle.capitalize,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                AppSize.spacing.heightBox,
                AppFormField(
                  labelText: "Recipient Mobile Number",
                  controller: recipientNumberTextController
                    ..text = chosenRecipient?.number! ?? recipientNumber ?? "",
                  suffixIcon: AppFormIcon(
                    icon: Assets.icons.smartPhone.svg(),
                    isRight: false,
                  ),
                  prefixIcon: AppFormIcon(
                    countryCode: recipientCountry?.countryCode!,
                  ),
                  keyboardType: TextInputType.number,
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
                  readOnly: true,
                  onTap: () {
                    buildModalBottomSheetForRecipient(context);
                  },
                ),
                AppSize.spacing.heightBox,
                AppFormField(
                  labelText: "Amount to receive",
                  prefixIcon: const AppFormIcon(
                    icon: Icon(Iconsax.wallet),
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                  initialValue: amountToReceiveTextController.value.text,
                ),
                AppSize.spacing.heightBox,
                AppFormField(
                  labelText: "Recipient",
                  controller: recipientNameTextController
                    ..text = chosenRecipient?.firstName ?? recipientName ?? "",
                  prefixIcon: const AppFormIcon(
                    icon: Icon(Iconsax.user_search),
                  ),
                  suffixIcon: const AppFormIcon(
                    icon: Icon(Iconsax.search_normal),
                    isRight: false,
                  ),
                  readOnly: true,
                  onChanged: (value) {
                    ref
                        .read(recipientNameProvider.notifier)
                        .update((state) => value);
                  },
                ),
                AppSize.tripleSpacing.heightBox
              ],
            ),

          /**
           * Column widget fees details
           */

          FeeDetailsContainer()
        ],
      ),
    ).paddingSymmetric(horizontal: AppSize.padding);
  }

  Future<dynamic> buildModalBottomSheetForRecipient(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (__) {
        return ReceiverFilterWidget();
      },
    );
  }
}
