import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Onboarding/repository/onboarding_repository.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    final onboardRepoProvider = onboardingRepositoryProvider;
    super.initState();
    Timer(Durations.extralong4, () {
      final onboardingValue = ref.watch(onboardRepoProvider).requireValue;
      (onboardingValue.isOnboardingComplete())
          ? context.goNamed(AppRoutes.idiom.name)
          : context.goNamed(AppRoutes.onboarding.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appColors.secondary,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: AppSize.mdContainerSize,
              left: -AppSize.tripleSpacing,
              right: -AppSize.xlContainerSize * .9,
              child: Assets.icons.sendSplashIcon.svg(),
            ),
            Positioned(
              top: AppSize.tripleSpacing * 2.5,
              left: -AppSize.tripleSpacing * 30,
              right: -AppSize.tripleSpacing,
              child: Assets.images.splashUi.svg(),
            ),
            Positioned(
              left: AppSize.doubleSpacing ,
              top: AppSize.mdContainerSize * 1.8,
              child: Assets.images.upayza.image(scale: 4),
            ),
          ],
        ),
      ),
    );
  }
}
