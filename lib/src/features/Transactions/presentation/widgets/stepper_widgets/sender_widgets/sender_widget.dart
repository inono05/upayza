import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/components/app_title.dart';

import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class SenderWidget extends ConsumerWidget {
  const SenderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTitle(
            title: "Card Informations",
            fontWeight: FontWeight.bold,
          ),
          const AppTitle.h5(
            title: "Amount to send",
            fontWeight: FontWeight.bold,
          ),
          AppSize.spacing.heightBox,
          const AppFormField(
            labelText: 'Card Holder',
            prefixIcon: AppFormIcon(
              icon: Icon(Iconsax.user),
            ),
          ),
          const AppFormField(
            labelText: 'Card Number',
            prefixIcon: AppFormIcon(
              icon: Icon(Iconsax.code),
            ),
          ),
          Row(
            children: [
              const AppFormField(
                labelText: 'Expired Date',
                prefixIcon: AppFormIcon(
                  icon: Icon(Iconsax.calendar),
                ),
              ).expanded(),
              const AppFormField(
                labelText: 'CVV',
                prefixIcon: AppFormIcon(
                  icon: Icon(Iconsax.lock),
                ),
              ).expanded(),
            ],
          ),
          const AppFormField(
            labelText: 'Amount',
            keyboardType: TextInputType.number,
            prefixIcon: AppFormIcon(
              icon: Icon(Iconsax.wallet),
            ),
          ),
        ],
      ),
    );
  }
}
