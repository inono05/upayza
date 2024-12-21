import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

import '../../../Transactions/repository/transaction_repository.dart';

class StatusView extends ConsumerWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final responseTransfer = ref.watch(transferResponseProvider);
    final status = responseTransfer?.status?.toLowerCase();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 25.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: status!.contains('rejected')
                ? AppAlertDialog.error(message: responseTransfer!.status!)
                : (status.contains('completed'))
                    ? AppAlertDialog.success(message: responseTransfer!.status!)
                    : AppAlertDialog(message: responseTransfer!.status!),
          ),
          AppSize.tripleSpacing.heightBox,
          Row(
            children: [
              AppButton.secondary(
                title: "Receipt",
                icon: Iconsax.document_download,
                onPressed: () {},
              ).expanded(),
              AppButton(
                title: "Go Home",
                icon: IconlyLight.home,
                onPressed: () {
                  ref.refresh(transfersProvider.future);
                  context.goNamed(AppRoutes.histories.name);
                },
              ).expanded(),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: AppSize.padding),
    );
  }
}
