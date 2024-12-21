import 'package:flutter/material.dart';
import 'package:upayza/generated/fonts.gen.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AppTextTheme {
  AppTextTheme._();

  static textTheme({required ColorScheme colorScheme}) => TextTheme(
        displayLarge: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h0,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w800,
        ),
        displayMedium: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h1,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w800,
        ),
        displaySmall: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h2,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h3,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h4,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h5,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          fontFamily: FontFamily.nexa,
          fontSize: AppSize.h6,
          color: colorScheme.tertiary,
          letterSpacing: .6,
          height: 1.7,
          fontWeight: FontWeight.w700,
        ),
      );
}
