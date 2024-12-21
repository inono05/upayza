import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/transaction_box_widget.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class TransactionPanelWidget extends ConsumerWidget {
  const TransactionPanelWidget({super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Stack(
        children: [
          Column(
            children: [
              TransactionBoxWidget(color: color),
              TransactionBoxWidget(color: color),
            ],
          ),
          Positioned(
            top: AppSize.tripleSpacing * 5.7,
            left: AppSize.tripleSpacing,
            right: AppSize.tripleSpacing,
            child: CircleAvatar(
              backgroundColor: context.colorScheme.primary,
              radius: AppSize.xsContainerSize,
              child: Icon(
                Iconsax.arrow_swap,
                color: AppConstants.appColors.background,
              ),
            ),
          ),
        ],
      ),
    ).animate().slide(
      duration: 500.ms,
      curve: Curves.easeIn,
    );
  }
}
