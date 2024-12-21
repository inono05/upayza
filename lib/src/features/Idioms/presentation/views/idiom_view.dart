import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Idioms/domains/idiom.dart';
import 'package:upayza/src/features/Idioms/presentation/controllers/idiom_controller.dart';
import 'package:upayza/src/features/Idioms/presentation/widgets/idiom_tile_widget.dart';
import 'package:upayza/src/shared/components/app_logo_bubble.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';
import 'package:upayza/src/shared/states/locale/app_locale_state.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class IdiomView extends ConsumerWidget {
  const IdiomView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Idiom> idioms = [
      Idiom(
        title: T(context).french,
        code: 'fr',
        flag: 'https://www.worldometers.info/img/flags/fr-flag.gif',
      ),
      Idiom(
        title: T(context).english,
        code: 'en',
        flag: 'https://www.worldometers.info/img/flags/uk-flag.gif',
      ),
      Idiom(
        title: T(context).spanish,
        code: 'es',
        flag: 'https://www.worldometers.info/img/flags/sp-flag.gif',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppLogoBubble(),
            Assets.icons.language
                .svg(
                  height: AppSize.smContainerSize * 1.2,
                  width: AppSize.smContainerSize * 1.2,
                )
                .paddingSymmetric(
                  horizontal: AppSize.halfPadding,
                ),
            AppSize.tripleSpacing.heightBox,
            const AppTitle(
              title: AppString.languageDescription,
              fontWeight: FontWeight.w500,
              maxLines: 3,
            )
                .animate()
                .flipH(duration: 150.ms, curve: Curves.easeInBack)
                .paddingSymmetric(
                  horizontal: AppSize.halfPadding,
                ),
            AppSize.tripleSpacing.heightBox,
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.0,
                mainAxisSpacing: 15,
                crossAxisSpacing: 1
              ),
              itemCount: idioms.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final idiom = idioms.elementAt(index);
                return IdiomTileWidget(idiom: idiom).onTap(() {
                  ref
                      .read(idiomControllerProvider.notifier)
                      .setIdiom(idiom.code);
                  final localeState = appLocaleStateProvider;
                  ref
                      .read(localeState.notifier)
                      .setLocale(localeCode: idiom.code);
                });
              },
            ).expanded(flex: 5),
            const Spacer(),
            AppButton(
              title: T(context).next,
              onPressed: () {
                (AppUserPreferences().token() != null)
                    ? context.goNamed(AppRoutes.transactions.name)
                    : context.goNamed(AppRoutes.authenticate.name);
              },
            ),
            AppSize.tripleSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}
