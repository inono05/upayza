import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../components/app_alert_dialog.dart';
import 'app_helpers.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class AppListItemBuilder<T> extends StatelessWidget {
  const AppListItemBuilder({
    super.key,
    required this.asyncValue,
    required this.itemBuilder,
    this.axis = Axis.vertical,
    required this.items,
  });

  final AsyncValue asyncValue;
  final ItemWidgetBuilder<T> itemBuilder;
  final Axis axis;
  final List<T> items;

  toggleModelName() {
    final model = T.toString().split('JSonResponse').first;
    return ('${model}s').toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (items) {
        return ListView.builder(
          scrollDirection: axis,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return itemBuilder(context, items[index]);
          },
        );
      },
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
