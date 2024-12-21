import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod/riverpod.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class AppAsyncValueWidget<T> extends StatelessWidget {
  const AppAsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
    this.axis = Axis.vertical,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T) data;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: data,
      error: (e, st) => Center(
        child: AppHelpers.showAlert(
          context: context,
          child: AppAlertDialog.error(
            message: e.toString(),
          ),
        ),
      ),
      loading: () => Center(
        child: SpinKitRipple(
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
