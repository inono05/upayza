import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class HistoryUserOwnerWidget extends StatelessWidget {
  const HistoryUserOwnerWidget({
    super.key,
    required this.t,
  });

  final Transaction t;

  @override
  Widget build(BuildContext context) {
    final fullName = "${t.recipient?.firstName } ${t.recipient?.lastName}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTitle.h5(
          title: fullName.toUpperCase(),
          fontWeight: FontWeight.w600,
        ),
        const AppTitle.h6(title: AppString.transactionType),
        AppSize.halfPadding.heightBox,
        AppHelpers.checkStatus(t),
      ],
    );
  }
}
