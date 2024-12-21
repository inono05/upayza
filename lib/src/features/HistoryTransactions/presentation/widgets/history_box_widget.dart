import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/HistoryTransactions/presentation/widgets/amount_widget.dart';
import 'package:upayza/src/features/HistoryTransactions/presentation/widgets/history_user_owner_widget.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';
import 'package:upayza/src/shared/components/app_image_container.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/material_sized_box.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

import '../../../Transactions/presentation/views/transaction_details_view.dart';

class HistoryBoxWidget extends ConsumerWidget {
  const HistoryBoxWidget({
    super.key,
    required this.transaction,
    required this.name,
  });

  final Transaction transaction;
  final String name;

  @override
  Widget build(BuildContext context, ref) {
    final country = transaction.recipient?.operator?.country!;
    final sender = AppUserPreferences().getUser();

    return MaterialSizedBox(
      elevation: 1.2,
      color: Colors.white,
      hPadding: AppSize.halfSpacing,
      vPadding: AppSize.halfPadding / 2,
      child: SizedBox(
        height: AppSize.containerSize / 1.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (AppSize.halfPadding / 2).heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Badge(
                  backgroundColor: Colors.transparent,
                  alignment: Alignment.bottomRight,
                  smallSize: AppSize.spacing,
                  label: AppImageContainer(
                    imageUrl: country!.flag!,
                    size: AppSize.spacing,
                  ),
                  child: CircleAvatar(
                    radius: AppSize.doubleBorderRadius * 1.4,
                    child: AppTitle.h4(
                      title: name,
                      fontWeight: FontWeight.w700,
                      color: context.surface,
                    ).toCenter(),
                  ),
                ),
                HistoryUserOwnerWidget(t: transaction),
                AmountWidget(t: transaction),
              ],
            )
          ],
        ),
      ),
    ).onTap(
      () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: AppSize.xlContainerSize,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.borderRadius),
                  topRight: Radius.circular(AppSize.borderRadius),
                ),
              ),
              child: Column(
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () {
                      context.pop();
                    },
                    label: const AppTitle(title: 'Close'),
                    icon: const Icon(Iconsax.close_circle),
                  ).alignAtTopRight(),
                  TransactionInformationWidget(
                    detailIcon: const Icon(Iconsax.receipt),
                    detailTitle: "Reference",
                    detailFees: "${transaction.reference}",
                  ),
                  TransactionInformationWidget(
                    detailIcon: const Icon(Iconsax.receipt),
                    detailTitle: "Recipient Number",
                    detailFees: "${transaction.recipient?.number}",
                  ),
                  TransactionInformationWidget(
                    detailIcon: const Icon(Iconsax.receipt),
                    detailTitle: "Amount",
                    detailFees:
                        "${AppHelpers.formatNumber(transaction.netAmount!)} ${transaction.currency}",
                  ),
                  TransactionInformationWidget(
                    detailIcon: const Icon(Iconsax.receipt),
                    detailTitle: "Fees",
                    detailFees:
                        "${AppHelpers.formatNumber(transaction.feeAmount!)} ${transaction.currency}",
                  ),
                  TransactionInformationWidget(
                    detailIcon: const Icon(Iconsax.receipt),
                    detailTitle: "Sender",
                    detailFees: AppHelpers.fullName(
                      name: sender!.firstName!,
                      surname: sender.lastName,
                    ),
                  ),
                ],
              ).paddingSymmetric(
                horizontal: AppSize.padding,
                vertical: AppSize.padding,
              ),
            );
          },
        );
      },
    );
  }
}
