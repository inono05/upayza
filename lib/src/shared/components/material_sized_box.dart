import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../constants/app_sizes.dart';

class MaterialSizedBox extends StatelessWidget {
  const MaterialSizedBox({
    super.key,
    this.elevation,
    this.color,
    required this.child, this.hPadding, this.vPadding,
  });

  final double? elevation;
  final Color? color;
  final Widget child;
  final double? hPadding;
  final double? vPadding;
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color ?? context.colorScheme.primary.withOpacity(.85),
      elevation: 1.2,
      borderRadius: BorderRadius.circular(AppSize.borderRadius),
      child: child,
    ).paddingSymmetric(vertical: vPadding ?? AppSize.padding, horizontal: hPadding ?? 0,);
  }
}
