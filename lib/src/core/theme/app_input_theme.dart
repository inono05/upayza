import 'package:flutter/material.dart';
import 'package:upayza/src/shared/constants/app_colors_scheme.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AppInputTheme {
  AppInputTheme._();

  static InputDecorationTheme inputDecorationTheme({
    required ColorScheme colorScheme,
  }) {
    return InputDecorationTheme(
      border: _outlineInputBorder(colorScheme.secondary),
      focusedBorder: _outlineInputBorder(
        AppColorsScheme.lightColorScheme.secondary,
      ),
      errorBorder: _outlineInputBorder(colorScheme.error),
      enabledBorder: _outlineInputBorder(
        colorScheme.secondary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSize.spacing,
        vertical: AppSize.spacing * 1.2,
      ),
    );
  }

  static OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadius),
      borderSide: BorderSide(
        color: color,
        width: .71,
      ),
      gapPadding: 12,
    );
  }
}
