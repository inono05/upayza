import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/utils/app_exceptions.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = AppExceptions.message(error);
      log(message!);
      AppHelpers.showAlert(
        context: context,
        child: AppAlertDialog.error(
          message: message,
        ),
      );
    }
  }
}
