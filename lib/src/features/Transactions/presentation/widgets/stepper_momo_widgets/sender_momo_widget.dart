import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/repository/deposit_number_repository.dart';
import 'package:upayza/src/core/repository/gateway_repository.dart';
import 'package:upayza/src/features/Countries/presentation/controllers/country_controller.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/gateway_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/stepper_momo_widgets/deposit_modal_sheet.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

import '../../../../../core/models/deposit_number_json_response.dart';
import '../../../../../shared/components/app_alert_dialog.dart';
import '../../../../../shared/components/app_title.dart';
import '../../../../../shared/components/fees_details_container.dart';
import '../../../../../shared/components/forms/app_form_field.dart';
import '../../../../../shared/components/forms/app_form_prefix_icon.dart';
import '../../../../../shared/constants/app_sizes.dart';
import '../../../../../shared/constants/app_string.dart';
import '../../../../../shared/utils/app_helpers.dart';
import '../../controllers/state_controller.dart';

class SenderMomoWidget extends ConsumerWidget with FormValidationMixin {
  SenderMomoWidget({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  final amountToSendTextController = TextEditingController();
  final senderNumberTextController = TextEditingController();
  final purposeTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final senderDepositNumber = ref.watch(senderDepositNumberProvider);

    final gatewaysAsyncValue = ref.watch(gatewaysProvider);
    final depositNumberAsyncValue = ref.watch(depositNumbersProvider);
    final senderCountry = ref.watch(userCountryProvider);
    final senderGateway = ref.watch(senderGatewayProvider);
    final senderCountryFormatted = ref.watch(senderFormatCountryProvider);

    ref.listen(senderDepositNumberProvider, (prev, next) {
      senderNumberTextController.text = next!.value!;
    });

    debugPrint(senderCountryFormatted.toString());

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle.h5(title: AppString.title.capitalize),
              Row(
                children: [
                  const Icon(
                    IconlyLight.info_circle,
                    size: AppSize.iconSize / 1.7,
                  ),
                  AppSize.halfPadding.widthBox,
                  AppTitle.h5(
                    title: AppString.subtitle.capitalize,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              AppSize.doubleSpacing.heightBox,
              SizedBox(
                height: AppSize.containerSize / 1.7,
                child: gatewaysAsyncValue.when(
                  data: (data) {
                    final gateways = data.gateways ?? [];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gateways.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final gateway = gateways.elementAt(index);
                        return GatewayWidget(gateway: gateway).onTap(() {
                          ref
                              .read(senderGatewayProvider.notifier)
                              .update((state) => gateway);
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
              AppSize.tripleSpacing.heightBox,
            ],
          ),
          if (senderGateway != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitle.h5(title: "Sender Information's".capitalize),
                Row(
                  children: [
                    const Icon(
                      IconlyLight.info_circle,
                      size: AppSize.iconSize / 1.7,
                    ),
                    AppSize.halfPadding.widthBox,
                    AppTitle.h5(
                      title: AppString.senderSubtitle.capitalize,
                      fontWeight: FontWeight.w600,
                    ).expanded(),
                  ],
                ),
                AppSize.spacing.heightBox,
                depositNumberAsyncValue.when(
                  data: (data) {
                    final depositsNumbers = data.depositNumbers;
                    log("dep ==> ${senderDepositNumber?.value}");
                    return depositsNumbers.isNotEmpty
                        ? AppFormField(
                            labelText: "Sender Number",
                            controller: senderNumberTextController
                              ..text = senderDepositNumber?.value ?? "",
                            prefixIcon: AppFormIcon(
                              countryCode: senderCountry!.countryCode!,
                            ),
                            suffixIcon: const AppFormIcon(
                              icon: Icon(Iconsax.mobile),
                              isRight: false,
                            ),
                            keyboardType: TextInputType.number,
                            validator: inputValidator,
                            readOnly: true,
                            onTap: () {
                              bottomDepositNumber(
                                context,
                                depositNumbers: depositsNumbers,
                              );
                            },
                            inputFormatters: [
                              LibPhonenumberTextFormatter(
                                country: senderCountryFormatted!,
                                phoneNumberFormat:
                                    PhoneNumberFormat.international,
                                phoneNumberType: PhoneNumberType.mobile,
                              )
                            ],
                            onChanged: (value) {
                              ref
                                  .read(senderNumberProvider.notifier)
                                  .update((state) => value);
                            },
                          )
                        : FloatingActionButton.extended(
                            onPressed: () {
                              bottomDepositNumber(
                                context,
                                depositNumbers: depositsNumbers,
                              );
                            },
                            label: AppTitle(
                              title: "New Deposit Number",
                              color: context.surface,
                            ),
                            icon: Icon(
                              Iconsax.mobile,
                              color: context.surface,
                            ),
                          ).toCenter();
                  },
                  error: (err, stack) => AppAlertDialog.error(
                    message: err.toString(),
                  ),
                  loading: () => SpinKitRipple(
                    color: context.colorScheme.secondary,
                  ),
                ),
                AppSize.spacing.heightBox,
                if (senderDepositNumber != null)
                  AppFormField(
                    labelText: "Amount",
                    controller: amountToSendTextController
                      ..text = ref.watch(senderAmountProvider) ?? "",
                    prefixIcon: const AppFormIcon(
                      icon: Icon(Iconsax.wallet),
                    ),
                    keyboardType: TextInputType.number,
                    validator: inputValidator,
                    onChanged: (value) {
                      ref
                          .read(senderAmountProvider.notifier)
                          .update((state) => value.toString());
                    },
                  ),
                AppSize.spacing.heightBox,
                if (senderDepositNumber != null)
                  AppFormField(
                    labelText: "Purpose",
                    controller: purposeTextController
                      ..text = ref.watch(senderPurposeProvider) ?? "",
                    prefixIcon: const AppFormIcon(
                      icon: Icon(Iconsax.edit),
                    ),
                    keyboardType: TextInputType.multiline,
                    isTextArea: true,
                    validator: inputValidator,
                    onChanged: (value) {
                      ref
                          .read(senderPurposeProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                AppSize.tripleSpacing.heightBox,
              ],
            ),
          FeeDetailsContainer()
        ],
      ).paddingSymmetric(horizontal: AppSize.padding),
    );
  }

  void bottomDepositNumber(
    BuildContext context, {
    required List<DepositNumber> depositNumbers,
  }) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(.7),
      isScrollControlled: true,
      builder: (context) {
        return DepositModalSheet(
          depositNumbers: depositNumbers,
        );
      },
    );
  }
}
