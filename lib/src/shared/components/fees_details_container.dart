import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/shared/components/material_sized_box.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../constants/app_sizes.dart';
import 'app_timeline.dart';
import 'app_title.dart';

class FeeDetailsContainer extends StatelessWidget {
  FeeDetailsContainer({
    super.key,
  });

  final List<String> feesTitles = [
    "Quick transaction in a minute",
    "Exchange rate: 1 CAD = 456.1821 XAF",
    "Our fees: 0.2% + 5.90 CAD",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          feesTitles.length,
          (index) => AppTimeline(
            isFirst: index == 0,
            isLast: index == feesTitles.length - 1,
            child: MaterialSizedBox(
              child: AppTitle.h4(
                title: feesTitles[index],
                color: context.colorScheme.surface,
                fontWeight: FontWeight.w600,
              ).paddingSymmetric(
                vertical: AppSize.padding,
                horizontal: AppSize.padding,
              ),
            ).paddingOnly(left: AppSize.padding).animate().fadeIn(),
          ),
        )
      ],
    );
  }
}
