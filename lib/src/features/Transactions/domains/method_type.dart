import 'package:flutter/cupertino.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class MethodType {
  final String label;
  final String tag;
  final Widget iconType;

  MethodType({
    required this.label,
    required this.tag,
    required this.iconType,
  });
}

final methodTypes = <MethodType>[
  MethodType(
    label: "Mobile - Bank",
    tag: "M2B",
    iconType: Assets.icons.mobileCardBank.svg(
      height: AppSize.tripleSpacing,
      width: AppSize.tripleSpacing,
    ),
  ),
  MethodType(
    label: "Bank - Bank",
    tag: "B2B",
    iconType: Assets.icons.bankCardswap.svg(
      height: AppSize.tripleSpacing,
      width: AppSize.tripleSpacing,
    ),
  ),
  MethodType(
    label: "Bank - Mobile",
    tag: "B2M",
    iconType: Assets.icons.phoneTablet.svg(
      height: AppSize.tripleSpacing,
      width: AppSize.tripleSpacing,
    ),
  ),
  MethodType(
    label: "Mobile - Mobile",
    tag: "M2M",
    iconType: Assets.icons.smartPhone.svg(
      height: AppSize.tripleSpacing,
      width: AppSize.tripleSpacing,
    ),
  ),
];
