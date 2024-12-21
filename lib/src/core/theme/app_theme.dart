import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upayza/generated/fonts.gen.dart';
import 'package:upayza/src/core/theme/app_divider_theme.dart';
import 'package:upayza/src/shared/constants/app_colors_scheme.dart';
import 'package:upayza/src/core/theme/app_input_theme.dart';
import 'package:upayza/src/core/theme/app_text_theme.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData _theme({required Brightness brightness}) {
    final ColorScheme colorScheme = brightness == Brightness.light
        ? AppColorsScheme.lightColorScheme
        : AppColorsScheme.darkColorScheme;

    return ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: _textTheme(colorScheme: colorScheme).apply(
        fontFamily: FontFamily.nexa,
      ),
    ).copyWith(
      scaffoldBackgroundColor: colorScheme.surfaceTint,
      dividerTheme: AppDividerTheme.dividerTheme(colorScheme: colorScheme),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
            _textTheme(colorScheme: colorScheme).headlineMedium),
      ),
      appBarTheme: AppBarTheme(
        color: colorScheme.surface,
        elevation: 0,
        toolbarHeight: AppSize.smContainerSize/2,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: brightness,
          statusBarColor: Colors.transparent,
        ),
      ),
      inputDecorationTheme: AppInputTheme.inputDecorationTheme(
        colorScheme: colorScheme,
      ),
    );
  }

  static TextTheme _textTheme({required ColorScheme colorScheme}) {
    return AppTextTheme.textTheme(colorScheme: colorScheme);
  }

  static final ThemeData lightTheme = _theme(brightness: Brightness.light);
  static final ThemeData darkTheme = _theme(brightness: Brightness.dark);
}
