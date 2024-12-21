import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/shared/preferences/locale/app_locale_preferences.dart';

part 'idiom_controller.g.dart';
@riverpod
class IdiomController extends _$IdiomController {
  @override
  String build() {
    return AppLocalePreferences().locale().languageCode;
  }

  void setIdiom(value){
    state = value;
  }
}