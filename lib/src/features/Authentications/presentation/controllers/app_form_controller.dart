import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_form_controller.g.dart';


@riverpod
class RegisterCheckboxState extends _$RegisterCheckboxState {
  @override
  bool build() {
    return true;
  }

  void isChecked() {
    state = !state;
  }

}

final emailProvider = StateProvider<String>((ref) => '');
final hasErrorProvider = StateProvider<bool>((ref) => false);
final isEmailCheckProvider = StateProvider<bool>((ref) => false);
final usePhoneProvider = StateProvider<bool>((ref) => false);
final passwordVisibleProvider = StateProvider<bool>((ref) => true);
final confirmPwdVisibleProvider = StateProvider<bool>((ref) => true);