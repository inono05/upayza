import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/states/theme/app_theme_state.dart';

class ThemeModeSwitcherWidget extends ConsumerWidget {
  const ThemeModeSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeStateProvider);
    return SizedBox(
      height: AppSize.smContainerSize / 3,
      width: AppSize.smContainerSize,
      child: Switch(
        value: themeMode.name == "dark" ? true : false, //false or true
        onChanged: (value) {
          ref.read(appThemeStateProvider.notifier).setTheme();
        },
        activeColor: context.colorScheme.secondary,
      ),
    );
  }
}
