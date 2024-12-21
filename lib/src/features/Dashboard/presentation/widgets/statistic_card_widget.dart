import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class StatisticCardWidget extends StatelessWidget {
  const StatisticCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = AppConstants.appColors.surface;
    return Material(
      elevation: 3.5,
      color: context.colorScheme.secondary,
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: AppSize.smContainerSize * 1.4,
        width: AppSize.xlContainerSize,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSize.padding,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTitle.h5(
                    title: AppString.totalTransactions,
                    color: cardColor.withOpacity(.5),
                  ),
                  AppTitle.h4(
                    title: "${AppHelpers.formatNumber(9129)} CFA",
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.surface,
                  )
                ],
              ),
            ),
            Icon(
              Iconsax.wallet,
              color: context.colorScheme.surface,
            )
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: AppSize.padding);
  }
}
