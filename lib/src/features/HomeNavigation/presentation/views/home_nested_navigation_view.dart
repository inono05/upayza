import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upayza/src/features/HomeNavigation/presentation/widgets/home_navigation_widget.dart';

class HomeNestedNavigationView extends StatelessWidget {
  const HomeNestedNavigationView({
    super.key,
    required this.navigationShell,
  });

  void onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return HomeNavigationWidget(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
