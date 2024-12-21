import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class MethodTransferButton extends StatelessWidget {
  const MethodTransferButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppSize.borderRadius),
      color: AppConstants.appColors.secondary,
      elevation: 2.5,
      child: Container(
        height: AppSize.smContainerSize / 1.4,
        width: AppSize.containerSize / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
          color: AppConstants.appColors.secondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            AppTitle.h5(
              title: title,
              color: AppConstants.appColors.surface,
            )
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: AppSize.halfPadding/2.2).animate().slideY(
      delay: 100.ms,
      curve: Curves.bounceIn,
    );
  }
}
