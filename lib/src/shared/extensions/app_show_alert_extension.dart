import 'package:flutter/material.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/utils/app_exceptions.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

extension AppAlertNotify on AlertDialog{
  void onErrorNotify(BuildContext context, Object error){
    final message = AppExceptions.message(error);
    AppHelpers.showAlert(
      context: context,
      child: AppAlertDialog.error(message: message!),
    );
  }
}