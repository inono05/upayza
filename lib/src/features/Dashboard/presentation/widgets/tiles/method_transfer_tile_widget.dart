import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/features/Dashboard/domains/method_transfer.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/method_transfer_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';

class MethodTransferTileWidget extends StatelessWidget {
  const MethodTransferTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppSize.borderRadius,),
      elevation: 2.0,
      color: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: AppSize.containerSize / 1.3,
        width: context.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppTitle.h4(title: AppString.methodTransfer),
            SizedBox(
              child: Row(
                children: [
                  ...List.generate(
                    methods.length,
                    (index) {
                      final m = methods.elementAt(index);
                      return MethodTransferButton(
                        title: m.title,
                        icon: m.icon,
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ).paddingSymmetric(
          horizontal: AppSize.halfPadding,
          vertical: AppSize.halfPadding,
        ),
      ).animate().slide(delay: 100.ms, curve: Curves.slowMiddle),
    );
  }
}
