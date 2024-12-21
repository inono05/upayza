import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/application.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Authentications/domains/auth_json_response.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/auth_controller.dart';
import 'package:upayza/src/shared/components/app_container.dart';
import 'package:upayza/src/shared/components/app_more_tile.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_async_value_ui.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';


class LogoutWidget extends ConsumerWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (previous, next) {
      return next.showAlertOnError(context);
    });
    return AppContainer(
      child: AppMoreTile(
        title: 'Log Out',
        hasLine: false,
        leftIcon: Assets.icons.logout.svg(
          // ignore: deprecated_member_use_from_same_package
          color: context.colorScheme.error,
        ),
        onPressed: () {
          logoutModalSheet(context, ref);
          //context.goNamed(AppRoutes.splash.name);
        },
        widget: Icon(
          IconlyLight.arrow_right_2,
          color: context.colorScheme.onTertiary.withOpacity(.5),
        ),
      ),
    );
  }

  Future<dynamic> logoutModalSheet(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authStateNotifier = ref.read(authControllerProvider.notifier);
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: AppSize.mdContainerSize * 1.5,
          child: Column(
            children: [
              Icon(
                Iconsax.warning_2,
                color: context.colorScheme.error,
                size: AppSize.iconSize * 2,
              ),
              AppTitle(
                title: 'Are you sure you want to log out?',
                color: context.colorScheme.error,
              ),
              Row(
                children: [
                  AppButton(
                    title: 'Cancel',
                    onPressed: () {
                      context.router.pop();
                    },
                  ).expanded(),
                  AppButton(
                    title: 'Continue',
                    isLoading: authState.isLoading,
                    onPressed: authState.isLoading
                        ? null
                        : () async {
                            //context.router.pop();
                            final response = await authStateNotifier.logout();
                            if (response.isNotNull) {
                              context.goNamed(AppRoutes.splash.name);
                              if (context.mounted) {
                                UncontrolledProviderScope(
                                  container: ProviderContainer(),
                                  child: const Application(),
                                );

                              }
                            }
                          },
                  ).expanded(),
                ],
              ).paddingSymmetric(
                horizontal: AppSize.padding,
                vertical: AppSize.padding,
              ),
            ],
          ).paddingSymmetric(
            horizontal: AppSize.padding,
            vertical: AppSize.padding,
          ),
        ).paddingSymmetric(
          horizontal: AppSize.padding,
          vertical: AppSize.padding,
        );
      },
    );
  }
}
