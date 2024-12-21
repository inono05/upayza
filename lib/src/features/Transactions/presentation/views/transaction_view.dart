import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Transactions/domains/method_type.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/transaction_method_type_widget.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../controllers/state_controller.dart';

class TransactionView extends ConsumerWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final method = ref.watch(methodTypeProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle.h2(
              title: AppString.methods,
              fontWeight: FontWeight.w600,
            ),
            const AppTitle.h5(title: AppString.methodDescription),
            GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.doublePadding,
                vertical: AppSize.doublePadding,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: AppSize.doubleSpacing,
                mainAxisSpacing: AppSize.doubleSpacing,
              ),
              shrinkWrap: true,
              itemCount: methodTypes.length,
              itemBuilder: (context, index) {
                final type = methodTypes.elementAt(index);
                return TransactionMethodTypeWidget(
                  methodType: type,
                ).onTap(
                  () {
                    ref.read(methodTypeProvider.notifier).update((state) => type);
                  },
                );
              },
            ).expanded(),
            AppSize.tripleSpacing.heightBox,
            Icon(
              IconlyLight.info_circle,
              color: context.colorScheme.primary,
              size: AppSize.doubleIconSize,
            ).toCenter(),
            AppSize.doubleSpacing.heightBox,
            const AppTitle(
              title: AppString.feesDescription,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            AppSize.tripleSpacing.heightBox,
            AppButton(
              title: "Continue",
              onPressed: (method?.tag != 'M2M' ) ? null : () {
                (method!.tag.contains('M2M'))
                    ? context.goNamed(AppRoutes.transactionMomo.name)
                    : context.goNamed(AppRoutes.transactionStepper.name);
              },
            ),
            AppSize.doubleSpacing.heightBox,
          ],
        ).paddingSymmetric(horizontal: AppSize.padding).animate().slide(
              duration: 150.ms,
              curve: Curves.easeIn,
            ),
      ),
    );
  }
}
