import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';

import '../../../../shared/components/app_title.dart';
import '../../../../shared/constants/app_sizes.dart';

class AddCardView extends ConsumerWidget {
  AddCardView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cardHolderTextController = TextEditingController();
  final cardExpiredDateTextController = TextEditingController();
  final cardCvvTextController = TextEditingController();
  final cardNumberTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSize.spacing.heightBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Iconsax.arrow_left).onTap(() => context.pop()),
                AppSize.spacing.widthBox,
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitle(title: "Add Card"),
                    AppTitle.h4(title: "Add your debit or credit Card")
                  ],
                )
              ],
            ),
            AppSize.tripleSpacing.heightBox,
            ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppFormField(
                        controller: cardHolderTextController,
                        labelText: "Card Holder Name",
                      ),
                      AppFormField(
                        controller: cardNumberTextController,
                        labelText: "Card Number",
                      ),
                      Row(
                        children: [
                          AppFormField(
                            controller: cardExpiredDateTextController,
                            labelText: "Expired Date",
                          ).expanded(),
                          AppFormField(
                            controller: cardCvvTextController,
                            labelText: "CVV",
                          ).expanded(),
                        ],
                      )
                    ],
                  ),
                ),
              ]
            ).expanded(),
            AppButton(title: "save card", onPressed: (){},),
            AppSize.tripleSpacing.heightBox,
          ],
        ).paddingSymmetric(
          horizontal: AppSize.padding,
          vertical: AppSize.padding,
        ),
      ),
    );
  }
}
