import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

import 'operator_widget.dart';

class TransactionOperatorTileWidget extends ConsumerWidget {
  const TransactionOperatorTileWidget({
    super.key,
    required this.mainAlignment,
    this.operators = const [],
  });

  final MainAxisAlignment mainAlignment;
  final List<Operator> operators;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryOperators = operators
        .where((e) => e.country?.id == ref.watch(recipientCountryProvider)?.id)
        .toList();
    return countryOperators.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
      height: AppSize.containerSize / 2,
      child: Consumer(
        builder: (context, ref, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: countryOperators.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final operator = countryOperators.elementAt(index);
              return OperatorWidget(
                mainAlignment: mainAlignment,
                operator: operator,
              ).onTap(() {
                ref
                    .read(recipientOperatorProvider.notifier)
                    .update((state) => operator);
              });
            },
          );
        },
      ),
    ).paddingSymmetric(horizontal: AppSize.halfPadding);
  }
}
