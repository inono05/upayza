import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/shared/components/app_container.dart';
import 'package:upayza/src/shared/components/app_more_tile.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import '../../../../shared/components/logout_loader_widget.dart';
import '../../../Authentications/presentation/controllers/auth_controller.dart';

class AccountManagerWidget extends ConsumerWidget {
  const AccountManagerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppContainer(
      child: Column(
        children: [
          AppMoreTile(
            title: 'Account Manager',
            leftIcon: Assets.icons.userSquare.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.profile.name);
            },
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
          ),
          AppMoreTile(
            title: 'Security',
            leftIcon: Assets.icons.iconlyLightShieldDone.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
          ),
          /*AppMoreTile(
            title: 'QR code',
            leftIcon: Assets.icons.qrScan.svg(
              // ignore: deprecated_member_use_from_same_package
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
            widget: Icon(
              IconlyLight.arrow_right_2,
              color: context.colorScheme.onTertiary.withOpacity(.6),
            ),
            hasLine: false,
          ),*/
        ],
      ),
    );
  }
}
