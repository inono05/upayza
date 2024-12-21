import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required this.t,
  });

  final Transaction t;

  @override
  Widget build(BuildContext context) {
    final currency = t.currency;
    final date = Jiffy.parseFromDateTime(t.createdAt!).MEd;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppTitle.h5(
          title: "${AppHelpers.formatNumber(t.netAmount!)} $currency",
          fontWeight: FontWeight.w800,
        ),
        AppTitle.h6(title: date.toString()),
        AppSize.halfPadding.heightBox,
        Row(
          children: [
            Assets.icons.receiptBill
                .svg(
                  height: AppSize.spacing * 1.5,
                  width: AppSize.spacing * 1.5,
                )
                .onTap(() => null),
            AppSize.halfSpacing.widthBox,
            const Icon(
              Iconsax.more5,
              size: AppSize.spacing * 1.7,
            ).onTap(() => null)
          ],
        )
      ],
    );
  }
}
