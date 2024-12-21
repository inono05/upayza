import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

enum _AppAlertType { success, error, info }

class AppAlertDialog extends StatelessWidget {
  final String message;
  final _AppAlertType _appAlertType;
  final VoidCallback? onPressed;

  const AppAlertDialog({
    super.key,
    required this.message,
    this.onPressed,
  }) : _appAlertType = _AppAlertType.info;

  const AppAlertDialog.error({
    super.key,
    required this.message,
    this.onPressed,
  }) : _appAlertType = _AppAlertType.error;

  const AppAlertDialog.success({
    super.key,
    required this.message,
    this.onPressed,
  }) : _appAlertType = _AppAlertType.success;

  @override
  Widget build(BuildContext context) {
    late Widget alertIcon;
    //late String title;
    late String description;
    switch (_appAlertType) {
      case _AppAlertType.success:
        alertIcon = Assets.images.iconSuccess.image();
        //title = "Success";
        description = message;
        break;
      case _AppAlertType.error:
        alertIcon = Assets.images.iconError.image();
        //title = "Error";
        description = message;
        break;
      case _AppAlertType.info:
        alertIcon = Assets.images.iconInfo.image();
        //title = "Information";
        description = message;
        break;
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadius),
      ),
      elevation: 15.0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          alertIcon.paddingAll(AppSize.halfPadding),
          AppSize.halfPadding.heightBox,
          AppTitle.h4(
            title: description,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ).paddingAll(AppSize.halfPadding),
    );
  }
}
