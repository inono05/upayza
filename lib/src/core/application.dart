import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/core/i18n/l10n.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/core/theme/app_theme.dart';
import 'package:upayza/src/shared/states/locale/app_locale_state.dart';
import 'package:upayza/src/shared/states/theme/app_theme_state.dart';
import 'package:upayza/src/shared/utils/app_status_bar.dart';

class Application extends ConsumerWidget {
  const Application({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final themeMode = ref.watch(appThemeStateProvider);
    final locale = ref.watch(appLocaleStateProvider);
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    ref.watch(appStatusBar).setColor(ref: ref);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //themeMode: themeMode,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: I18n.delegate.supportedLocales,
    );
  }
}
