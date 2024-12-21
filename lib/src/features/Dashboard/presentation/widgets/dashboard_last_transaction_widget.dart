import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

import '../../../HistoryTransactions/presentation/widgets/history_list_builder.dart';

class DashboardLastTransactionWidget extends StatelessWidget {
  const DashboardLastTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.mdContainerSize * 1.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppTitle.h4(
                title: "Last Transactions",
                fontWeight: FontWeight.w500,
              ),
              const AppTitle.h4(
                title: "More",
                fontWeight: FontWeight.w500,
              ).onTap(() => context.goNamed(AppRoutes.histories.name))
            ],
          ),
          const HistoryListBuilder(minToShow: 4).expanded()
        ],
      ),
    );
  }
}
