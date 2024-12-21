import 'package:flutter/material.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class AppLogoBubble extends StatelessWidget {
  const AppLogoBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.mdContainerSize * 1.3,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            left: -AppSize.tripleSpacing,
            top: -AppSize.tripleSpacing * 1.7,
            child: Assets.images.bubble.svg(
              height: AppSize.mdContainerSize * 1.3,
              width: AppSize.mdContainerSize * 1.3,
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
          ),
          Positioned(
            left: AppSize.spacing,
            top: AppSize.xsContainerSize * 1.7,
            child: Assets.images.logo.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.surfaceTint,
              height: AppSize.logoSize,
              width: AppSize.logoSize,
            ),
          ),
        ],
      ),
    );
  }
}
