import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Transactions/domains/transfer_form_request.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/transaction_controller.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../views/transaction_details_view.dart';

class ConfirmTransferWidget extends ConsumerWidget {
  const ConfirmTransferWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final senderGateway = ref.watch(senderGatewayProvider);
    final senderDepositNumber = ref.watch(senderDepositNumberProvider);
    final sender = AppUserPreferences().getUser();
    final amountFrom = num.parse(ref.watch(senderAmountProvider)!);

    final recipientCountry = ref.watch(recipientCountryProvider);
    final recipient = ref.watch(recipientSelectedProvider);
    final amountTo = num.parse(ref.watch(recipientAmountProvider)!);
    final purpose = ref.watch(senderPurposeProvider);

    final currencyTo = recipientCountry?.currency ?? "CFA";
    final operatorTitle = recipient?.operator?.label?.toLowerCase();

    //initialize state transfer
    final transferState = ref.watch(transactionControllerProvider);
    final transferNotifier = ref.read(transactionControllerProvider.notifier);
    ref.listen(transactionControllerProvider, (prev, next) {
      return next.showAlertOnError(context);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTitle(title: "Amount").paddingOnly(left: AppSize.padding),
        AppSize.doubleSpacing.heightBox,
        Material(
          elevation: 5.0,
          //color: Colors.white,
          child: SizedBox(
            child: Column(
              children: [
                AppSize.doubleSpacing.heightBox,
                TransactionInformationWidget(
                  detailIcon: const Icon(Iconsax.trade),
                  detailTitle: "Transfer Amount",
                  detailFees: "$amountFrom $currencyTo",
                ),
                TransactionInformationWidget(
                  detailIcon: Assets.icons.coinToCardSwap.svg(),
                  detailTitle: "Transfer Fees",
                  detailFees: "2%",
                ),
                TransactionInformationWidget(
                  detailIcon: Assets.icons.coinToCardSwap.svg(),
                  detailTitle: "Total Charged",
                  detailFees:
                      "${AppHelpers.formatNumber((0.02 * amountFrom) + (amountFrom))} $currencyTo",
                ),
                TransactionInformationWidget(
                  detailIcon: const Icon(Iconsax.dollar_circle),
                  detailTitle: "Total Sent",
                  detailFees:
                      "${AppHelpers.formatNumber((0.02 * amountFrom) + (amountFrom))} $currencyTo",
                ),
                TransactionInformationWidget(
                  detailIcon: const Icon(Iconsax.dollar_circle),
                  detailTitle: "Total Recipient",
                  detailFees: "$amountTo $currencyTo",
                ),
                TransactionInformationWidget(
                  detailIcon: const Icon(Iconsax.paperclip),
                  detailTitle: "Purpose",
                  detailFees: purpose!,
                ),
                const TransactionInformationWidget(
                  detailIcon: Icon(Iconsax.trade),
                  detailTitle: "Exchange Rate",
                  detailFees: "1 CAD = 446,3852 CFA",
                ).paddingSymmetric(
                  horizontal: AppSize.padding,
                  vertical: AppSize.doublePadding,
                ),
              ],
            ).paddingSymmetric(horizontal: AppSize.padding),
          ),
        ),
        AppSize.tripleSpacing.heightBox,
        const AppTitle(title: "Recipient").paddingOnly(
          left: AppSize.padding,
        ),
        AppSize.doubleSpacing.heightBox,
        Material(
          elevation: 5.0,
          //color: Colors.white,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 8.2,
                  borderRadius: BorderRadius.circular(AppSize.halfSpacing),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.halfSpacing),
                    child: (operatorTitle!.contains('orange'))
                        ? Assets.images.om.image(scale: 10)
                        : (operatorTitle.contains('mtn'))
                            ? Assets.images.momo.image(scale: 10)
                            : Assets.images.koodo.image(scale: 10),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    AppTitle(
                      title: "${recipient?.lastName!} ${recipient?.firstName!}"
                          .capitalize,
                    ),
                    AppTitle.h4(
                      title: recipient!.number!,
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(
              horizontal: AppSize.padding,
              vertical: AppSize.padding,
            ),
          ),
        ),
        AppSize.tripleSpacing.heightBox,
        const AppTitle(title: "Payment Method").paddingOnly(
          left: AppSize.padding,
        ),
        AppSize.doubleSpacing.heightBox,
        Material(
          elevation: 5.0,
          //color: Colors.white,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 7.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.halfSpacing),
                    child:
                        (senderGateway!.label!.toLowerCase().contains('visa'))
                            ? Assets.images.visa.image()
                            : Assets.images.logo.svg(
                                height: AppSize.tripleSpacing * 1.2,
                                width: AppSize.tripleSpacing * 1.2,
                              ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    AppTitle(title: sender!.firstName!),
                    AppTitle.h4(title: "${senderDepositNumber?.value}"),
                  ],
                ),
              ],
            ).paddingSymmetric(
              horizontal: AppSize.padding,
              vertical: AppSize.padding,
            ),
          ).paddingOnly(bottom: AppSize.doubleSpacing),
        ),
        AppButton(
          title: "transfer".toUpperCase(),
          isLoading: transferState.isLoading,
          onPressed: transferState.isLoading
              ? null
              : () async {
                  final recipientSvcNumber = AppHelpers.getFullNumber(
                    recipientCountry!.countryCode!,
                    recipient.number!,
                  );
                  final request = TransferFormRequest(
                    userId: AppUserPreferences().userId(),
                    operatorId: recipient.operator?.id,
                    depositNumberId: senderDepositNumber?.id,
                    recipientId: recipient.id,
                    recipientSvcNumber: recipientSvcNumber.toString(),
                    amount: int.parse(amountTo.toString()),
                    reason: purpose,
                    currency: currencyTo,
                    signature: AppHelpers.signature(),
                    method: senderGateway.label!.toLowerCase(),
                  );
                  final response = await transferNotifier.transfer(request);
                  log(request.toString());
                  if (context.mounted) {
                    AppHelpers.resetAllProviders(ref);
                    ref
                        .read(transferResponseProvider.notifier)
                        .update((state) => response);

                    context.goNamed(AppRoutes.status.name);
                  }
                },
        ).paddingOnly(top: AppSize.padding)
      ],
    );
  }
}
