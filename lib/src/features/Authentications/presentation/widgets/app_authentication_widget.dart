import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AppAuthenticationButtonWidget extends StatelessWidget {
  const AppAuthenticationButtonWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.btnSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadius,
        ),
        border: Border.all(width: .5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [icon, AppTitle(title: title)],
      ),
    )
        .paddingSymmetric(
          vertical: AppSize.halfPadding,
        )
        .animate()
        .flipV(
          duration: 500.ms,
          curve: Curves.bounceIn,
        );
  }
}
