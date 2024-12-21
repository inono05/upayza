import 'package:flutter/material.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.secondary.withOpacity(
        .4,
      ),
      width: AppSize.smContainerSize / 14.5,
      height: AppSize.smContainerSize,
    );
  }
}
