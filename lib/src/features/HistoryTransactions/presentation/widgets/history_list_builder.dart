import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../shared/components/app_alert_dialog.dart';
import '../../../../shared/components/empty_widget.dart';
import '../../../../shared/constants/app_string.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../../../Transactions/repository/transaction_repository.dart';
import 'history_box_widget.dart';

class HistoryListBuilder extends ConsumerWidget {
  const HistoryListBuilder({
    super.key,
    this.minToShow,
    this.showFullPage = false,
  });

  final int? minToShow;
  final bool showFullPage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transferAsyncValue = ref.watch(transfersProvider);
    return transferAsyncValue.when(
      data: (datas) {
        final transfers = datas.transactions.reversed.toList();

        return transfers.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final transfer = transfers.elementAt(index);
                  final name = AppHelpers.generateInitial(
                    name: transfer.recipient!.firstName ?? 'N/',
                    surname: transfer.recipient!.lastName ?? 'A',
                  );
                  return HistoryBoxWidget(
                    transaction: transfer,
                    name: name,
                  );
                },
                itemCount: (minToShow != null)
                    ? transfers.take(minToShow!).length
                    : transfers.length,
                shrinkWrap: true,
              )
            : EmptyWidget(
                message: AppString.noTransfers,
                iconData: Iconsax.arrow_swap_horizontal,
                onPressed: () => context.goNamed(
                  AppRoutes.transactions.name,
                ),
              ).alignAtCenter();
      },
      error: (e, s) => AppAlertDialog.error(message: e.toString()),
      loading: () => SpinKitRipple(
        color: context.colorScheme.secondary,
      ).alignAtCenter(),
    );
  }
}
