import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.borderRadius),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 2.0),
            blurRadius: AppSize.borderRadius / 6.5,
            spreadRadius: AppSize.halfSpacing / 8,
            color: context.colorScheme.shadow.withOpacity(.1),
          )
        ],
      ),
      child: child,
    );
  }
}
