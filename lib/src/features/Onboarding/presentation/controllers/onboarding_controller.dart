import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/features/Onboarding/repository/onboarding_repository.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingState extends _$OnboardingState {
  @override
  FutureOr<void> build() {}
  Future<void> completeOnboarding() async {
    final onboardingRepository =
        ref.watch(onboardingRepositoryProvider).requireValue;
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }
}

@riverpod
class OnboardingNavigationState extends _$OnboardingNavigationState{
  @override
  int build() {
    return 0;
  }

  void increment(int value) {
    state = value;
  }

  void decrement(int value) {
    state = state - value;
  }
}