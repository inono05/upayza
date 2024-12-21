import 'dart:async';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/application.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/initializerAppWidget/app_initializer_widget.dart';
import 'package:upayza/src/shared/constants/app_colors_scheme.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

FlutterLocalNotificationsPlugin notificationsLocale =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // * Register error handlers. For more info, see:
  registerErrorHandlers();
  // * Entry point of the app
  runApp(
    ProviderScope(
      child: AppInitializerWidget(
        onLoaded: (context) => const Application(),
      ),
    ),
  );
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColorsScheme.lightColorScheme.surface,

        body:
        Material(
          elevation: 25.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSize.borderRadius,
            ),
          ),
          child: AppAlertDialog.error(
            message: (details.exception.toString().contains("timeout"))
                ? "Oops! check your internet connexion and reload"
                : details.exceptionAsString(),
          ),
        ).paddingSymmetric(horizontal: AppSize.doubleSpacing),
      ),
    );
  };
}
