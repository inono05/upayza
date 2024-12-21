import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/features/Profile/presentation/widgets/gender_radio_button_widget.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class GenderFormRadioWidget extends StatelessWidget {
  const GenderFormRadioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const GenderRadioButtonWidget(
          isMen: true,
          title: 'Men',
        ),
        AppSize.spacing.widthBox,
        const GenderRadioButtonWidget(
          isMen: false,
          title: "Female",
        )
      ],
    )
        .paddingSymmetric(
          horizontal: AppSize.halfPadding,
          vertical: AppSize.halfPadding,
        )
        .animate()
        .fadeIn(duration: 500.ms)
        .slide();
  }
}
