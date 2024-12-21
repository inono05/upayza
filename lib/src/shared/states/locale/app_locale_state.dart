import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/shared/preferences/locale/app_locale_preferences.dart';

part 'app_locale_state.g.dart';

@riverpod
class AppLocaleState extends _$AppLocaleState {
  @override
  Locale build() {
    return AppLocalePreferences().locale();
  }

  Locale getLocale() {
    return state;
  }

  void setLocale({required String localeCode}) {
    state = Locale(localeCode);
    AppLocalePreferences().updateLocale(state);
  }
}
