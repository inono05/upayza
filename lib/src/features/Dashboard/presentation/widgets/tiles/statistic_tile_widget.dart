import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/statistic_card_widget.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class StatisticTileWidget extends StatelessWidget {
  const StatisticTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadius,
        ),
      ),
      child: SizedBox(
        height: AppSize.mdContainerSize * 1.12,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: [
                  AppTitle.h5(
                    title: AppString.totalTransactions.toUpperCase(),
                  ),
                  AppTitle.h2(
                    title: "${AppHelpers.formatNumber(21879)} CFA",
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
            const StatisticCardWidget().paddingOnly(top: AppSize.halfPadding)
          ],
        ),
      ),
    ).paddingSymmetric(
      horizontal: AppSize.halfPadding,
      vertical: AppSize.halfPadding,
    );
  }
}
