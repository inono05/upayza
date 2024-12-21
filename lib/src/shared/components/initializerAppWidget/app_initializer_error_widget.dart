import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/core/theme/app_theme.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

import '../../../core/initializerApp/app_initializer.dart';

class AppInitializerErrorWidget extends ConsumerWidget {
  const AppInitializerErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInitializerState = ref.watch(appInitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              elevation: 25.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSize.borderRadius,
                ),
              ),
              child: AppAlertDialog.error(
                message: (message.contains("timeout"))
                    ? "Oops! check your internet connexion and reload"
                    : message,
              ),
            ).paddingSymmetric(horizontal: AppSize.padding),
            AppSize.tripleSpacing.heightBox,
            AppButton(
              icon: Iconsax.refresh,
              isLoading: appInitializerState.isLoading,
              title: "Retry",
              onPressed: appInitializerState.isLoading ? null : onRetry,
            )
          ],
        ).toCenter(),
      ),
    );
  }
}
