import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/HistoryTransactions/presentation/widgets/history_list_builder.dart';
import 'package:upayza/src/features/Transactions/repository/transaction_repository.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';


class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(transfersProvider.future),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (AppSize.tripleSpacing * 1.2).heightBox,
              const AppTitle.h2(
                title: AppString.history,
                fontWeight: FontWeight.w700,
              ),
              const AppTitle.h5(title: AppString.historyDescription),
              AppSize.doubleSpacing.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const AppTitle(
                    title: "Filter",
                    fontWeight: FontWeight.w800,
                  ),
                  AppSize.halfSpacing.widthBox,
                  Assets.icons.preferences.svg(),
                ],
              ),
              const HistoryListBuilder(showFullPage: true).expanded(),
            ],
          ),
        ).paddingSymmetric(horizontal: AppSize.padding).animate().slide(
              duration: 500.ms,
              curve: Curves.easeIn,
            ),
      ),
    );
  }
}
