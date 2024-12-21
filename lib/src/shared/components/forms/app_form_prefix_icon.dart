import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';


class AppFormIcon extends StatelessWidget {
  const AppFormIcon({
    super.key,
    this.icon,
    this.isRight = true,
    this.countryCode,
  });

  final Widget? icon;
  final bool isRight;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: !isRight
              ? BorderSide(
                  width: .7,
                  color: context.colorScheme.secondary,
                )
              : BorderSide.none,
          right: isRight
              ? BorderSide(
                  width: .6,
                  color: context.colorScheme.secondary,
                )
              : BorderSide.none,
        ),
      ),
      child: (countryCode == null)
          ? icon?.paddingOnly(
              right: isRight ? AppSize.spacing : 0,
              left: !isRight ? AppSize.spacing : 0,
            )
          : AppTitle(title: "+$countryCode").paddingOnly(
              right: AppSize.spacing,
            ),
    ).paddingSymmetric(
      horizontal: AppSize.padding,
      vertical: AppSize.padding,
    );
  }
}
