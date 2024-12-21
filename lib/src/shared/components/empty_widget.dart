
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../constants/app_sizes.dart';
import '../constants/app_string.dart';
import 'app_title.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.message,
    this.icon,
    this.onPressed,
    this.iconData,
  });
  final String? message;
  final Widget? icon;
  final IconData? iconData;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon ??
            Icon(
              iconData ?? IconlyLight.add_user,
              size: AppSize.tripleSpacing * 2,
            ),
        AppTitle(
          title: message ?? AppString.noRecipients,
          maxLines: 5,
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: AppSize.doubleSpacing),
        FloatingActionButton(
          onPressed: onPressed,
          child: Icon(
            iconData ?? IconlyLight.add_user,
            color: context.colorScheme.surface,
          ),
        )
      ],
    );
  }
}