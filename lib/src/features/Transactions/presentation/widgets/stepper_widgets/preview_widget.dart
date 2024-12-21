import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Transactions/presentation/views/transaction_details_view.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: AppTitle(
            title: 'Sender Overview',
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          initiallyExpanded: true,
          children: [
            Column(
              children: [
                const TransactionInformationWidget(
                  detailIcon: Icon(Iconsax.user),
                  detailTitle: "Sender Name",
                  detailFees: "Loïc NSILI",
                ),
                const TransactionInformationWidget(
                  detailIcon: Icon(Iconsax.trade),
                  detailTitle: "Transaction Method",
                  detailFees: "RBC Payment",
                ),
                TransactionInformationWidget(
                  detailIcon: const Icon(Iconsax.dollar_circle),
                  detailTitle: "Amount Send",
                  detailFees: "${AppHelpers.formatNumber(500)} CAD",
                ),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: AppTitle(
            title: 'Receiver Overview',
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          initiallyExpanded: true,
          children: [
            Column(
              children: [
                const TransactionInformationWidget(
                  detailIcon: Icon(Iconsax.user),
                  detailTitle: "Receiver Name",
                  detailFees: "Idriss NONO",
                ),
                const TransactionInformationWidget(
                  detailIcon: Icon(Iconsax.wallet),
                  detailTitle: "Payment Method",
                  detailFees: "Orange Money",
                ),
                TransactionInformationWidget(
                  detailIcon: const Icon(Iconsax.dollar_circle),
                  detailTitle: "Amount Receive",
                  detailFees: "${AppHelpers.formatNumber(223200)} Fcfa",
                ),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: AppTitle(
            title: 'Transactions Overview',
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          initiallyExpanded: true,
          children: [
            Column(
              children: [
                TransactionInformationWidget(
                  detailIcon: Assets.icons.coinToCardSwap.svg(),
                  detailTitle: "Transaction Fees",
                  detailFees: "${AppHelpers.formatNumber(1.50)} CAD",
                ),
                const TransactionInformationWidget(
                  detailIcon: Icon(Iconsax.trade),
                  detailTitle: "Exchange Rate",
                  detailFees: "1 CAD = 446,3852 Fcfa",
                ),
                TransactionInformationWidget(
                  detailIcon: Assets.icons.receiptBill.svg(),
                  detailTitle: "Net to Debit",
                  detailFees: "${AppHelpers.formatNumber(501.50)} CAD",
                ),
                TransactionInformationWidget(
                  detailIcon: Assets.icons.receiptBill.svg(),
                  detailTitle: "Net to Receive",
                  detailFees: "${AppHelpers.formatNumber(223200)} Fcfa",
                ),
                TransactionInformationWidget(
                  detailIcon: Assets.icons.stopwatch.svg(),
                  detailTitle: "Delay",
                  detailFees: "90s",
                ),
                TransactionInformationWidget(
                  detailIcon: Assets.icons.iconlyLightCalendar.svg(),
                  detailTitle: "Transaction Date",
                  detailFees: AppConstants.dateAgo,
                ),
              ],
            ),
          ],
        ),
        AppSize.spacing.heightBox,
        AppButton(
          title: 'Transfer',
          onPressed: () {
            Timer(700.ms, () {
              AppHelpers.showAlert(
                context: context,
                child: const AppAlertDialog.success(
                  message: 'Transaction success',
                ),
              );
            });
          },
        ),
      ],
    );
  }
}
