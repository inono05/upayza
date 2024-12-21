import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/auth.dart';
import 'package:upayza/src/shared/components/app_more_tile.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

import '../../../../core/application.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../shared/utils/app_helpers.dart';
import '../../../Authentications/presentation/controllers/auth_controller.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.watch(authControllerProvider.notifier);
    final user = ref.watch(userProvider);

    ref.listen(authControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSize.spacing.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Iconsax.arrow_left).onTap(() => GoRouter.of(context).pop()),
                  AppSize.spacing.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTitle(title: T(context).more),
                      const AppTitle.h4(title: "Account Manager")
                    ],
                  )
                ],
              ),
              AppSize.tripleSpacing.heightBox,
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: context.colorScheme.primary.withOpacity(.2),
                      width: .2,
                    ),
                    bottom: BorderSide(
                      color: context.colorScheme.primary.withOpacity(.3),
                      width: .2,
                    ),
                  ),
                ),
                child: AppMoreTile(
                  title: "Welcome ${user?.firstName}",
                  hasLine: false,
                  hasSize: true,
                  color: context.colorScheme.primary,
                  leftIcon: Assets.icons.userCircle.svg(
                    color: context.colorScheme.primary,
                    height: AppSize.iconSize * 2,
                    width: AppSize.iconSize * 2,
                  ),
                  widget: Assets.icons.logout.svg(
                    color: context.colorScheme.error,
                  ).onTap(() async{
                    final response = await authStateNotifier.logout();
                    if (context.mounted && response != null) {
                      UncontrolledProviderScope(
                        container: ProviderContainer(),
                        child: const Application(),
                      );
                      context.goNamed(AppRoutes.splash.name);
                      AppHelpers.notify(context, response.message!);
                    }
                  }),
                ).paddingSymmetric(vertical: AppSize.halfPadding),
              ),
              AppSize.spacing.heightBox,
              AppMoreTile(
                title: "My Recipients",
                leftIcon: Assets.icons.iconlyLightUser.svg(
                  color: context.colorScheme.primary,
                ),
                hasLine: false,
                widget: Icon(
                  IconlyLight.arrow_right_2,
                  color: context.colorScheme.onTertiary.withOpacity(.5),
                ),
                onPressed: () => GoRouter.of(context).pushNamed(AppRoutes.recipients.name),
              ).paddingSymmetric(vertical: AppSize.halfPadding),
              AppMoreTile(
                title: "My ${T(context).transaction}",
                leftIcon: Assets.icons.swapHorizontal.svg(
                  color: context.colorScheme.primary,
                ),
                hasLine: false,
                widget: Icon(
                  IconlyLight.arrow_right_2,
                  color: context.colorScheme.onTertiary.withOpacity(.5),
                ),
                onPressed: () {},
              ).paddingSymmetric(vertical: AppSize.halfPadding),
              AppMoreTile(
                title: "My ${T(context).card}",
                leftIcon: Assets.icons.bankCarddoubleOutline.svg(
                  color: context.colorScheme.primary,
                ),
                hasLine: false,
                widget: Icon(
                  IconlyLight.arrow_right_2,
                  color: context.colorScheme.onTertiary.withOpacity(.5),
                ),
                onPressed: () {},
              ).paddingSymmetric(vertical: AppSize.halfPadding),
              AppMoreTile(
                title: "My Profile",
                leftIcon: Assets.icons.userSquare.svg(
                  color: context.colorScheme.primary,
                ),
                hasLine: false,
                widget: Icon(
                  IconlyLight.arrow_right_2,
                  color: context.colorScheme.onTertiary.withOpacity(.5),
                ),
                onPressed: () {},
              ).paddingSymmetric(vertical: AppSize.halfPadding),
              AppMoreTile(
                title: "My Settings",
                leftIcon: Assets.icons.setting.svg(
                  color: context.colorScheme.primary,
                ),
                hasLine: false,
                widget: Icon(
                  IconlyLight.arrow_right_2,
                  color: context.colorScheme.onTertiary.withOpacity(.5),
                ),
                onPressed: () {},
              ).paddingSymmetric(vertical: AppSize.halfPadding),
              AppSize.doubleSpacing.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withOpacity(.3),
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                ),
                child: AppMoreTile(
                  title: "Contact Support",
                  fontWeight: FontWeight.bold,
                  leftIcon: Assets.icons.headphone.svg(
                    color: context.colorScheme.primary,
                    height: AppSize.iconSize * 2,
                    width: AppSize.iconSize * 2,
                  ),
                  hasLine: false,
                  onPressed: () {},
                ).paddingSymmetric(vertical: AppSize.halfPadding),
              ).paddingSymmetric(horizontal: AppSize.padding),
              AppSize.doubleSpacing.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppMoreTile(
                    title: "Privacy Policy",
                    leftIcon: const SizedBox.shrink(),
                    onPressed: () {},
                    widget: Icon(
                      IconlyLight.arrow_right_2,
                      color: context.colorScheme.onTertiary.withOpacity(.5),
                    ).paddingOnly(left: AppSize.halfPadding),
                  ),
                  AppMoreTile(
                    title: "language",
                    leftIcon: const SizedBox.shrink(),
                    onPressed: () {},
                    widget: Icon(
                      IconlyLight.arrow_right_2,
                      color: context.colorScheme.onTertiary.withOpacity(.5),
                    ),
                  ),
                ],
              )
            ],
          ),
        ).paddingSymmetric(
          horizontal: AppSize.padding,
          vertical: AppSize.padding,
        ),
      ),
    );
  }
}
