import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AppAuthenticationHeader extends StatelessWidget {
  const AppAuthenticationHeader({
    super.key,
    this.title,
    this.description,
  });

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (AppSize.tripleSpacing * 2.4).heightBox,
        Assets.images.upayza.image(scale: AppSize.iconSize / 3.5),
        AppSize.doubleSpacing.heightBox,
        AppTitle.h2(
          title: title ?? "Welcome back!",
          fontWeight: FontWeight.w700,
        ).paddingOnly(left: AppSize.halfPadding),
        AppSize.halfSpacing.heightBox,
        AppTitle.h4(
          title: description ?? "Please enter your credentials",
          maxLines: 4,
        ).paddingOnly(left: AppSize.halfPadding),
        AppSize.tripleSpacing.heightBox,
      ],
    ).animate().flipH(duration: 500.ms).slide();
  }
}
