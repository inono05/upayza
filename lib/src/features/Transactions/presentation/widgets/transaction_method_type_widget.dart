import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Transactions/domains/method_type.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class TransactionMethodTypeWidget extends ConsumerWidget {
  const TransactionMethodTypeWidget({
    super.key,
    required this.methodType,
    this.isChecked = false,
  });

  final MethodType methodType;
  final bool isChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerColor = context.colorScheme;
    final method = ref.watch(methodTypeProvider);
    final isEqual = identical(methodType, method);
    return Material(
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius,
      ),
      elevation: 1.5,
      color: isEqual
          ? containerColor.primary
          : containerColor.surface,
      child: SizedBox(
        height: AppSize.containerSize * 1.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                methodType.iconType.setOpacity(opacity: isEqual ? 1 : .5),
                isEqual
                    ? Assets.icons.checkCircleSuccess.svg(
                        height: AppSize.doubleSpacing,
                        width: AppSize.doubleSpacing,
                        color: context.colorScheme.surface,
                      )
                    : Assets.icons.checkCircle
                        .svg(
                          height: AppSize.spacing,
                          width: AppSize.spacing,
                        )
                        .setOpacity(opacity: isEqual ? 1 : .5),
              ],
            ),
            AppSize.spacing.heightBox,
            AppTitle.h6(
              title: methodType.tag,
              fontWeight: FontWeight.bold,
              color: isEqual
                  ? containerColor.surface
                  : containerColor.scrim,
            ),
            AppTitle.h5(
              title: methodType.label,
              fontWeight: FontWeight.bold,
              color: isEqual
                  ? containerColor.surface
                  : containerColor.scrim,
            ),
          ],
        ).paddingSymmetric(
          horizontal: AppSize.spacing * 1.6,
          vertical: AppSize.spacing * 1.8,
        ),
      ),
    );
  }
}
