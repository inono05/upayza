import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class TransactionDetailsView extends StatelessWidget {
  const TransactionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSize.spacing.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Iconsax.arrow_left).onTap(() => context.pop()),
                  AppSize.spacing.widthBox,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTitle(title: AppString.transfer),
                      AppTitle.h4(title: AppString.transferDescription)
                    ],
                  )
                ],
              ),
              AppSize.tripleSpacing.heightBox,
              //const TransactionOperatorTileWidget(mainAlignment: mainAlignment),
              AppSize.tripleSpacing.heightBox,
              SizedBox(
                child: Column(
                  children: [
                    TransactionInformationWidget(
                      detailIcon: Assets.icons.coinToCardSwap.svg(),
                      detailTitle: "Transaction Fees",
                      detailFees: "${AppHelpers.formatNumber(1.50)} CAD",
                    ),
                    TransactionInformationWidget(
                      detailIcon: Assets.icons.receiptBill.svg(),
                      detailTitle: "Net to Debit",
                      detailFees: "${AppHelpers.formatNumber(75.50)} CAD",
                    ),
                    TransactionInformationWidget(
                      detailIcon: Assets.icons.stopwatch.svg(),
                      detailTitle: "Delay",
                      detailFees: "60s",
                    ),
                    TransactionInformationWidget(
                      detailIcon: Assets.icons.iconlyLightCalendar.svg(),
                      detailTitle: "Transaction Date",
                      detailFees: AppConstants.dateAgo,
                    ),
                  ],
                ),
              ),
              AppButton(title: T(context).next, onPressed: (){},)
            ],
          ),
        ).paddingSymmetric(
          horizontal: AppSize.padding,
          vertical: AppSize.padding,
        ),
      ),
    );
  }
}

class TransactionInformationWidget extends StatelessWidget {
  const TransactionInformationWidget({
    super.key,
    required this.detailTitle,
    required this.detailIcon,
    required this.detailFees,
  });
  final String detailTitle;
  final Widget detailIcon;
  final String detailFees;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              detailIcon,
              AppSize.spacing.widthBox,
              AppTitle.h5(title: detailTitle)
            ],
          ),
        ),
        AppSize.spacing.widthBox,
        AppTitle.h4(
          title: detailFees,
          fontWeight: FontWeight.w700,
        ),
      ],
    ).paddingSymmetric(vertical: AppSize.padding/1.2);
  }
}
