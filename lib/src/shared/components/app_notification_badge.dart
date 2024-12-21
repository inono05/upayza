import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

import 'app_title.dart';

class AppNotificationBadge extends ConsumerWidget {
  const AppNotificationBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Badge(
      label: AppTitle.h6(
        title: 5.toString(),
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      child: Assets.icons.ringtone.svg(
        width: AppSize.mdImageSize * 1.2,
        height: AppSize.mdImageSize * 1.2,
      ),
    );
  }
}