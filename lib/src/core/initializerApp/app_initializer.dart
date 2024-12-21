import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/firebase_options.dart';
import 'package:upayza/src/core/repository/deposit_number_repository.dart';
import 'package:upayza/src/core/repository/operator_repository.dart';
import 'package:upayza/src/features/Authentications/repositories/auth_repository.dart';
import 'package:upayza/src/features/Countries/repository/country_repository.dart';
import 'package:upayza/src/features/Onboarding/repository/onboarding_repository.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';
import 'package:upayza/src/shared/preferences/app_local_storage.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';
import 'package:upayza/src/shared/preferences/locale/app_locale_preferences.dart';
import 'package:upayza/src/shared/preferences/theme/app_theme_preferences.dart';
import 'package:upayza/src/shared/push_notifications/app_firebase_messaging.dart';

part 'app_initializer.g.dart';

@Riverpod(keepAlive: true)
Future<void> appInitializer(AppInitializerRef ref) async {
  ref.onDispose(() {
    ref.invalidate(appLocalePreferencesProvider);
    ref.invalidate(onboardingRepositoryProvider);
    ref.invalidate(apiProvider);
    ref.invalidate(authRepositoryProvider);
    ref.invalidate(countriesProvider);
    ref.invalidate(operatorsProvider);
    ref.invalidate(depositNumbersProvider);
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppFirebaseMessaging().init();
  await AppLocalePreferences.ensureInitialized();
  await AppUserPreferences.ensureInitialized();
  await AppThemePreferences.ensureInitialized();
  await AppLocaleStore.ensureInitialized();
  await ref.watch(onboardingRepositoryProvider.future);
  await ref.watch(countriesProvider.future);
  await init();
}

