import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Recipients/repository/recipient_repository.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../../../../shared/components/app_title.dart';
import '../../../../shared/components/empty_widget.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../widgets/recipient_tile_widget.dart';

class RecipientView extends ConsumerWidget {
  const RecipientView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipientsAsyncValue = ref.watch(recipientsProvider);
    final goRouter = GoRouter.of(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(recipientsProvider.future),
        child: SafeArea(
          child: Column(
            children: [
              AppSize.spacing.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Iconsax.arrow_left).onTap(() {
                    GoRouter.of(context).pop();
                  }),
                  AppSize.spacing.widthBox,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTitle(title: "Recipients"),
                      AppTitle.h4(title: "Manage your recipients")
                    ],
                  )
                ],
              ),
              AppSize.tripleSpacing.heightBox,
              recipientsAsyncValue.when(
                data: (data) {
                  final recipients = data.recipients.reversed;
                  return recipients.isEmpty
                      ? const EmptyWidget()
                      : ListView.builder(
                          itemCount: recipients.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final recipient = recipients.elementAt(index);
                            final name = AppHelpers.generateInitial(
                              name: recipient.lastName!,
                              surname: recipient.firstName!,
                            );
                            final splashColor = context.colorScheme.primary;
                            return RecipientTileWidget(
                              splashColor: splashColor,
                              recipient: recipient,
                              name: name.toUpperCase(),
                            );
                          },
                        ).expanded();
                },
                error: (err, s) => AppAlertDialog.error(message: err.toString(),),
                loading: () => SpinKitRipple(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ).paddingSymmetric(
            horizontal: AppSize.padding,
            vertical: AppSize.padding,
          ),
        ),
      ),
      floatingActionButton: recipientsAsyncValue.maybeWhen(
        orElse: () => null,
        data: (data) => FloatingActionButton(
          onPressed: () {
            ref.read(recipientCountryProvider.notifier).update((state) => null);
            ref
                .read(recipientOperatorProvider.notifier)
                .update((state) => null);

            goRouter.pushNamed(AppRoutes.addRecipients.name);
          },
          elevation: 5,
          child: Icon(
            IconlyLight.add_user,
            color: context.surface,
          ),
        ),
      ),
    );
  }
}
