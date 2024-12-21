import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/deposit_controller.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../../../../../core/models/deposit_number_json_response.dart';
import '../../../../../shared/components/app_title.dart';
import '../../../../../shared/constants/app_sizes.dart';
import '../../controllers/state_controller.dart';
import 'deposit_modal_sheet.dart';

class DepositModalSheetListView extends ConsumerWidget {
  const DepositModalSheetListView({
    super.key,
    required this.depositNumbers,
    required this.depositNumberState,
    required this.depositNumberNotifier,
  });

  final List<DepositNumber> depositNumbers;
  final AsyncValue<DepositNumberObjectJSonResponse?> depositNumberState;
  final DepositController depositNumberNotifier;

  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final depositNumber = depositNumbers.elementAt(index);
        final operator = depositNumber.operator;
        final depositNumberCode = operator?.country?.code;
        final depositNumberLabel = operator?.label?.split(' ').first;
        return Material(
          elevation: .20,
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSize.halfPadding / 2,
              horizontal: AppSize.halfPadding,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppTitle.h5(
                      title: depositNumber.value!,
                      fontWeight: FontWeight.w700,
                    ),
                    OperatorBadgeWidget(
                      depositNumberLabel: depositNumberLabel,
                      depositNumberCode: depositNumberCode,
                    ),
                  ],
                ),
                Row(
                  children: [
                    DepositNumberActionWidget(
                      actionIcon: IconlyLight.edit,
                      backgroundColor: context.colorScheme.primary,
                      action: 'edit',
                      depositNumbers: depositNumbers,
                      valueState: depositNumberState,
                      depositNumber: depositNumber,
                      controller: depositNumberNotifier,
                    ),
                    (AppSize.halfPadding / 2).widthBox,
                    DepositNumberActionWidget(
                      action: 'delete',
                      actionIcon: IconlyLight.delete,
                      backgroundColor: context.colorScheme.error,
                      depositNumbers: depositNumbers,
                      valueState: depositNumberState,
                      depositNumber: depositNumber,
                      controller: depositNumberNotifier,
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              ref
                  .read(senderDepositNumberProvider.notifier)
                  .update((state) => depositNumber);

              GoRouter.of(context).pop();
            },
          ),
        ).paddingSymmetric(
          horizontal: AppSize.padding,
          vertical: AppSize.halfPadding / 2,
        );
      },
      itemCount: depositNumbers.length,
    );
  }
}
