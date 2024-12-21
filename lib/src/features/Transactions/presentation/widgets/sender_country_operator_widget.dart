import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../../../../core/models/operator_json_response.dart';
import '../../../../shared/components/app_title.dart';
import '../../../../shared/constants/app_sizes.dart';
import '../controllers/state_controller.dart';

class SenderCountryOperatorWidget extends ConsumerWidget {
  const SenderCountryOperatorWidget({
    super.key,
    required this.mainAlignment,
    this.operators = const [],
    this.userCountryId,
  });

  final MainAxisAlignment mainAlignment;
  final List<Operator> operators;
  final int? userCountryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryOperators = operators
        .where(
          (e) => e.country?.id == userCountryId!,
        )
        .toList();
    return countryOperators.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSize.doubleSpacing.heightBox,
              AppTitle.h6(title: "Mobile Money Operator".toUpperCase()),
              AppSize.spacing.heightBox,
              SizedBox(
                height: AppSize.containerSize / 1.9,
                child: Consumer(
                  builder: (context, ref, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: countryOperators.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final operator = countryOperators.elementAt(index);
                        return CountryOperatorWidget(
                          mainAlignment: mainAlignment,
                          operator: operator,
                        ).onTap(() {
                          ref
                              .read(senderOperatorProvider.notifier)
                              .update((state) => operator);
                        });
                      },
                    );
                  },
                ),
              )
            ],
          ).paddingSymmetric(horizontal: AppSize.halfPadding);
  }
}

class CountryOperatorWidget extends ConsumerWidget {
  const CountryOperatorWidget({
    super.key,
    required this.mainAlignment,
    required this.operator,
  });

  final MainAxisAlignment mainAlignment;
  final Operator operator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenOperator = ref.watch(senderOperatorProvider);
    final isOperatorIdentical = identical(operator, chosenOperator);
    return Material(
      elevation: 3.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius,
      ),
      color: isOperatorIdentical ? context.colorScheme.primary : Colors.white,
      child: Container(
        height: AppSize.containerSize / 1.8,
        width: AppSize.containerSize * 1.3,
        margin: const EdgeInsets.only(
          right: AppSize.halfPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
          color:
              isOperatorIdentical ? context.colorScheme.primary : Colors.white,
        ),
        foregroundDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(isOperatorIdentical ? 0 : 1),
          backgroundBlendMode: BlendMode.saturation,
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
        ),
        child: AppTitle.h5(
          title: operator.label!,
          fontWeight: FontWeight.w600,
          color: isOperatorIdentical
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
