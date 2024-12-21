import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/tiles/dashboard_action_tile_widget.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/dashboard_header_widget.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/dashboard_last_transaction_widget.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/tiles/method_transfer_tile_widget.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/tiles/statistic_tile_widget.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/tiles/transaction_starter_tile_widget.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
               DashboardHeaderWidget().paddingOnly(top: AppSize.doublePadding),
              const  StatisticTileWidget().paddingOnly(top: AppSize.padding),
              const  DashboardActionTileWidget().paddingOnly(top: AppSize.padding),
              const MethodTransferTileWidget().paddingOnly(top: AppSize.padding),
              const TransactionStarterTileWidget().paddingOnly(top: AppSize.padding),
              const DashboardLastTransactionWidget().paddingOnly(top: AppSize.padding),
            ],
          )
              .paddingSymmetric(horizontal: AppSize.padding)
              .animate()
              .slideY(
                delay: 100.ms,
                curve: Curves.elasticIn,
              )
              .shimmer(
                delay: 100.ms,
              ),
        ),
      ),
    );
  }
}
