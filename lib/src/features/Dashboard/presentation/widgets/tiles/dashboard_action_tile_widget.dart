import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/features/Dashboard/presentation/controllers/action_controller.dart';
import 'package:upayza/src/features/Dashboard/domains/dashboard_action.dart';
import 'package:upayza/src/shared/components/buttons/action_transaction_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class DashboardActionTileWidget extends ConsumerWidget {
  const DashboardActionTileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionSelectedProvider = ref.read(actionControllerProvider.notifier);
    return LimitedBox(
      maxHeight: AppSize.smContainerSize,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final dashboardAction = actions.elementAt(index);
          return ActionTransactionButton(
            dashboardAction: dashboardAction,
            index: index,
          ).onTap(() => actionSelectedProvider.actionSelected(index));
        },
      ),
    );
  }
}
