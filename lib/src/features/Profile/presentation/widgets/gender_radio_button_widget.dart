import 'package:flutter/material.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class GenderRadioButtonWidget extends StatelessWidget {
  const GenderRadioButtonWidget({
    super.key,
    required this.isMen,
    required this.title,
  });

  final bool isMen;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: AppSize.smContainerSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
          border: Border.all(
            width: .8,
            color: context.colorScheme.secondary,
          ),
        ),
        child: RadioListTile(
          title: AppTitle(
            title: title,
          ),
          value: isMen,
          groupValue: isMen,
          onChanged: (value) {},
          activeColor: context.colorScheme.secondary,
          controlAffinity: ListTileControlAffinity.trailing,
        ),
      ),
    );
  }
}
