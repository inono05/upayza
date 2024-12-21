import 'package:flutter/cupertino.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class MethodTransfer {
  String title;
  Widget icon;

  MethodTransfer({
    required this.title,
    required this.icon,
  });
}

final methods = <MethodTransfer>[
  MethodTransfer(
    title: "Bank",
    icon: Assets.icons.phone.svg(),
  ),
  MethodTransfer(
    title: "Mobile",
    icon: Assets.icons.bankCard.svg(
      color: AppConstants.appColors.surface,
    ),
  ),
];
