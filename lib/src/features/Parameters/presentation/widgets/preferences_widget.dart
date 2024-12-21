import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Parameters/presentation/widgets/theme_mode_switcher_widget.dart';
import 'package:upayza/src/shared/components/app_container.dart';
import 'package:upayza/src/shared/components/app_more_tile.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class PreferencesWidget extends StatelessWidget {
  const PreferencesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppMoreTile(
            title: 'Notifications',
            leftIcon: Assets.icons.notification.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
          ),
          AppMoreTile(
            title: 'Language',
            leftIcon: Assets.icons.translateLanguage.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
          ),
          AppMoreTile(
            title: 'Dark Mode',
            leftIcon: Assets.icons.starsSquare.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ThemeModeSwitcherWidget(),
                AppSize.doubleSpacing.widthBox,
                Icon(
                  IconlyLight.arrow_right_2,
                  color: context.colorScheme.onTertiary.withOpacity(
                    .6,
                  ),
                ),
              ],
            ),
          ),
          AppMoreTile(
            title: 'Copyright',
            leftIcon: Assets.icons.copyright.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
          ),
          AppMoreTile(
            title: 'Privacy Policy',
            hasLine: false,
            leftIcon: Assets.icons.folderShield.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }
}
