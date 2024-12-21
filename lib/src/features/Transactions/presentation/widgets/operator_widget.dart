import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class OperatorWidget extends ConsumerWidget {
  const OperatorWidget({
    super.key,
    required this.mainAlignment,
    required this.operator,
  });

  final MainAxisAlignment mainAlignment;
  final Operator operator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOperator = ref.watch(recipientOperatorProvider);
    return Material(
      elevation: 2.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius,
      ),
      color: identical(operator, selectedOperator)
          ? context.colorScheme.primary
          : Colors.white,
      child: Container(
        height: AppSize.containerSize / 1.8,
        width: AppSize.containerSize * 1.5,
        margin: const EdgeInsets.only(
          right: AppSize.halfPadding,
        ),

        foregroundDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(identical(operator, selectedOperator) ? 0 : 1),
          backgroundBlendMode: BlendMode.saturation,
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
        ),
        child: AppTitle.h4(
          title: operator.label!,
          fontWeight: FontWeight.w500,
          color: identical(operator, selectedOperator)
              ? context.colorScheme.surface
              : context.colorScheme.primary,
        ).toCenter(),
      ),
    ).paddingSymmetric(
      horizontal: AppSize.halfPadding,
      vertical: AppSize.halfPadding / 2,
    );
  }
}
