import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({
    super.key, required this.status,
  });

  final String status;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppConstants.appColors.surfaceTint,
      borderRadius: BorderRadius.circular(AppSize.borderRadius / 2),
      child: Container(
        width: AppSize.xsContainerSize * 3,
        decoration: BoxDecoration(
          color: AppConstants.appColors.surfaceTint,
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        child: status.contains('failed') ? AppConstants.failedTitle.toCenter() : status.contains('completed') ? AppConstants.successTitle.toCenter() :  AppConstants.inQueueTitle.toCenter(),
      ),
    );
  }
}
