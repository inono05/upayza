import 'package:flutter/material.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AppDividerTheme {
  AppDividerTheme._();
  static dividerTheme({required ColorScheme colorScheme}) => DividerThemeData(
        space: 1,
        color: colorScheme.secondaryContainer,
        indent: AppSize.padding,
        endIndent: AppSize.padding,
        thickness: 1,
      );
}
