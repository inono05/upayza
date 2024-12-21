import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/HomeNavigation/domains/ui_data_home.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class HomeNavigationWidget extends StatelessWidget {
  const HomeNavigationWidget({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    List<UiDataHome> data = [
      UiDataHome(
        label: T(context).home,
        icon: const Icon(Iconsax.home_2),
        selectedIcon: Icon(
          Iconsax.home_15,
          color: context.colorScheme.primary,
        ),
      ),
      UiDataHome(
        label: T(context).card,
        icon: const Icon(Iconsax.card),
        selectedIcon: Icon(
          Iconsax.cards,
          color: context.colorScheme.primary,
        ),
      ),
      UiDataHome(
        label: '',
        icon: CircleAvatar(
          backgroundColor: context.colorScheme.primary,
          child: const Icon(
            Iconsax.arrow_swap,
            color: Colors.white,
          ),
        ),
        selectedIcon: CircleAvatar(
          backgroundColor: context.colorScheme.primary,
          child: const Icon(
            Iconsax.arrow_swap,
            color: Colors.white,
          ),
        ),
      ),
      UiDataHome(
        label: T(context).history,
        icon: const Icon(Iconsax.chart_21),
        selectedIcon: Icon(
          Iconsax.chart_15,
          color: context.colorScheme.primary,
        ),
      ),
      UiDataHome(
        label: T(context).more,
        icon: const Icon(Iconsax.more),
        selectedIcon: Icon(
          IconlyBold.more_circle,
          color: context.colorScheme.primary,
        ),
      ),
    ];
    return Scaffold(
      body: body.paddingOnly(top: AppSize.padding),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: context.colorScheme.surface,
        elevation: 0.0,
        indicatorColor: Colors.transparent,
        indicatorShape: const CircleBorder(),
        destinations: [
          ...data.map(
            (e) => NavigationDestination(
              icon: e.icon!,
              label: e.label!,
              selectedIcon: e.selectedIcon,
              tooltip: e.label,
            ),
          )
        ],
      ),
    );
  }
}
