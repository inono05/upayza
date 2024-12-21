import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/features/Dashboard/domains/dashboard_action.dart';
import 'package:upayza/src/features/Dashboard/presentation/controllers/action_controller.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class ActionTransactionButton extends ConsumerWidget {
  const ActionTransactionButton({
    super.key,
    required this.dashboardAction,
    required this.index,
    this.widthSize = AppSize.containerSize * 1.7,
  });

  final int index;
  final double widthSize;
  final DashboardAction dashboardAction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionSelected = ref.watch(actionControllerProvider);
    final color = context.colorScheme.primary;
    return Material(
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius,
      ),
      color: actionSelected == index ? color : Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1.5,
      child: Container(
        width: widthSize/1.4,
        color: actionSelected == index ? color.withOpacity(.12) : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dashboardAction.icon,
            AppSize.padding.widthBox,
            AppTitle.h5(
              title: dashboardAction.title,
              fontWeight: FontWeight.w500,
              color: actionSelected == index
                  ? context.colorScheme.surface
                  : context.colorScheme.secondary,
            ),
          ],
        ),
      ),
    )
        .paddingSymmetric(
          horizontal: AppSize.halfSpacing,
          vertical: AppSize.halfSpacing,
        )
        .withTooltip(dashboardAction.title)
        .animate()
        .shimmer(delay: const Duration(microseconds: 500))
        .scale();
  }
}
