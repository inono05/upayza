import 'package:flutter/material.dart';
import 'package:upayza/generated/assets.gen.dart';

class DashboardAction {
  String title;
  Widget icon;

  DashboardAction({
    required this.title,
    required this.icon,
  });
}

final actions = <DashboardAction>[
  DashboardAction(
    title: 'Sent',
    icon: Assets.icons.sendMessage.svg(),
  ),
  DashboardAction(
    title: 'Receive',
    icon: Assets.icons.downArrow.svg(),
  ),
  DashboardAction(
    title: 'Exchange Rate',
    icon: Assets.icons.preferences.svg(),
  ),
  DashboardAction(
    title: 'Manage',
    icon: Assets.icons.filter.svg(),
  ),
];
