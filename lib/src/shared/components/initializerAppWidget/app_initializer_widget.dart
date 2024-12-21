import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/initializerApp/app_initializer.dart';
import 'package:upayza/src/core/theme/app_theme.dart';
import 'package:upayza/src/shared/components/initializerAppWidget/app_initializer_error_widget.dart';
import 'package:upayza/src/shared/components/initializerAppWidget/app_initializer_loading_widget.dart';

class AppInitializerWidget extends ConsumerWidget {
  const AppInitializerWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInitializerState = ref.watch(appInitializerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: appInitializerState.when(
        data: (_) => onLoaded(context),
        error: (err, stack) => AppInitializerErrorWidget(
          message: err.toString(),
          onRetry:  () => ref.invalidate(appInitializerProvider),
        ),
        loading: () => const AppInitializerLoadingWidget(),
      ),
    );
  }
}
