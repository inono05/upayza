import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_colors_scheme.dart';
import 'package:upayza/src/shared/constants/app_string.dart';

class AppConstants{
  AppConstants._();
  static ColorScheme appColors = AppColorsScheme.lightColorScheme;
  static double amount = 7000.95;
  static AppTitle successTitle = const AppTitle.h6(
    title: AppString.transactionSuccess,
    color: Colors.teal,
    fontWeight: FontWeight.w700,
  );
  static AppTitle failedTitle = AppTitle.h6(
    title: AppString.transactionFail,
    color: appColors.error,
    fontWeight: FontWeight.w700,
  );
  static AppTitle inQueueTitle = AppTitle.h6(
    title: AppString.transactionInProcess,
    color: appColors.primary,
    fontWeight: FontWeight.w700,
  );
  static String dateAgo = Jiffy.now().MEd;
  //static String dateAgo = Jiffy.parseFromDateTime(DateTime(2024, 10, 20)).fromNow();

}

enum Status{
  failed,
  enqueued,
  completed,
  accepted,
  submitted,

}