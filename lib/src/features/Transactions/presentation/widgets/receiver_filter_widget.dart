import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/Recipients/repository/recipient_repository.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/recipient_form.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/mixins/form_validation_mixin.dart';

import '../../../../shared/components/app_title.dart';
import '../../../../shared/components/forms/app_form_field.dart';
import '../../../../shared/components/forms/app_form_prefix_icon.dart';
import '../../../../shared/constants/app_sizes.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../../../Recipients/presentations/widgets/recipient_tile_widget.dart';

class ReceiverFilterWidget extends ConsumerWidget with FormValidationMixin {
  ReceiverFilterWidget({
    super.key,
  });

  final searchReceiverController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final recipientAsyncValue = ref.watch(recipientsProvider);
    final isRecipientCreated = ref.watch(hasRecipientProvider);
    final filteredRecipients = ref.watch(filteredRecipientsProvider).reversed.toList();
    return SizedBox(
      height: context.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSize.tripleSpacing.heightBox,
          AppTitle.h5(title: "Choose the recipient".capitalize),
          Row(
            children: [
              const Icon(
                IconlyLight.info_circle,
                size: AppSize.iconSize / 1.7,
              ),
              AppSize.halfPadding.widthBox,
              AppTitle.h5(
                title: "Choose recipient or add if not exist".capitalize,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          if (!isRecipientCreated)
            AppFormField(
              labelText: "Search For Recipient",
              controller: searchReceiverController,
              prefixIcon: const AppFormIcon(
                icon: Icon(
                  Iconsax.user_search,
                ),
              ),
              onChanged: (value) {
                ref.read(searchReceiverTextProvider.notifier).state = value!;
              },
              onEditingComplete: () {},
            ).paddingSymmetric(vertical: AppSize.padding),

          /**
           * listView Builder for
           * recipient's
           */
          if (!isRecipientCreated)
            SizedBox(
              height: context.height / 3.5,
              child: recipientAsyncValue.when(
                data: (data) {
                  return filteredRecipients.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppTitle.h6(title: "Saved Recipients"),
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final recipient =
                                    filteredRecipients.elementAt(index);
                                final name = AppHelpers.generateInitial(
                                  name: recipient.lastName!,
                                  surname: recipient.firstName!,
                                );
                                final splashColor = context.colorScheme.primary;
                                return RecipientTileWidget(
                                  splashColor: splashColor,
                                  recipient: recipient,
                                  name: name.toUpperCase(),
                                ).onTap(() {
                                  ref
                                      .watch(recipientSelectedProvider.notifier)
                                      .update((state) => recipient);
                                  context.pop();
                                });
                              },
                              itemCount: filteredRecipients.length,
                            ).expanded(),
                          ],
                        )
                      : FloatingActionButton.extended(
                          onPressed: () {
                            ref
                                .read(hasRecipientProvider.notifier)
                                .update((state) => !isRecipientCreated);
                          },
                          label: AppTitle(
                            title: 'Create a recipient',
                            color: context.colorScheme.surface,
                          ),
                          icon: Icon(
                            IconlyLight.add_user,
                            color: context.colorScheme.surface,
                          ),
                        ).toCenter();
                },
                error: (e, s) => AppAlertDialog.error(message: e.toString(),),
                loading: () => SpinKitRipple(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          if (isRecipientCreated) RecipientForm(),
          /**
           * Back button
           * use to close the modal
           */
          const Spacer(),
          TextButton(
            onPressed: () {
              if(!isRecipientCreated){
                ref.invalidate(recipientsProvider);
                context.pop();
              }else{
                ref
                    .read(hasRecipientProvider.notifier)
                    .update((state) => !isRecipientCreated);
              }
            },
            child: const Row(
              children: [Icon(Iconsax.arrow_left), AppTitle(title: "Back")],
            ),
          ),
        ],
      ),
    ).paddingSymmetric(
      horizontal: AppSize.padding,
      vertical: AppSize.doublePadding,
    );
  }
}
