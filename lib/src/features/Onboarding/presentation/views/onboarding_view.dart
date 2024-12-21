import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lorem_gen/lorem_gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/features/Onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:upayza/src/shared/components/app_logo_bubble.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class OnboardingView extends ConsumerWidget {
  OnboardingView({super.key});
  final titles = [
    Lorem.text().substring(0, 27),
    Lorem.text().substring(0, 27),
    Lorem.text().substring(0, 27),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingNavProvider = onboardingNavigationStateProvider;
    final state = ref.watch(onboardingStateProvider);
    final currentIndex = ref.watch(onboardingNavProvider);
    final controller = PageController(initialPage: currentIndex);

    Widget dot(length, {int index = 0}) {
      final indexValue = currentIndex;
      final dotTile = List.generate(
        length,
        (index) => Container(
          height: AppSize.borderRadius * 1.2,
          width: AppSize.borderRadius * 1.2,
          margin: const EdgeInsets.only(right: AppSize.halfSpacing),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: .8,
              color: context.colorScheme.scrim,
            ),
            color: indexValue == index
                ? context.colorScheme.primary
                : Colors.grey.shade100,
          ),
        ),
      );
      return Row(
        children: [...dotTile],
      ).paddingSymmetric(
        horizontal: AppSize.doublePadding,
        vertical: AppSize.doublePadding,
      );
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppLogoBubble(),
            AppTitle(
              title: titles.elementAt(currentIndex),
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ).paddingSymmetric(horizontal: AppSize.doublePadding),
            dot(titles.length, index: currentIndex),
            Expanded(
              child: PageView(
                controller: controller,
                children: List.generate(
                  titles.length,
                  (index) => AppTitle.h4(
                    title: Lorem.paragraph().capitalize,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                  ),
                ),
                onPageChanged: (value) {
                  ref.read(onboardingNavProvider.notifier).increment(value);
                  log("index ===> $currentIndex");
                },
              ).paddingSymmetric(horizontal: AppSize.doublePadding),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if ((currentIndex > 0))
                  Expanded(
                    child: AppButton(
                      title: "Back",
                      onPressed: () {
                        controller.previousPage(
                          duration: const Duration(microseconds: 5),
                          curve: Curves.bounceIn,
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: AppButton(
                    title: (currentIndex == 2) ? "Get Started" : "Next",
                    isLoading: state.isLoading,
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            if (currentIndex == 2) {
                              await ref
                                  .read(onboardingStateProvider.notifier)
                                  .completeOnboarding();
                              if (context.mounted) {
                                // go to sign in page after completing onboarding
                                context.goNamed(AppRoutes.idiom.name);
                              }
                            } else {
                              controller.nextPage(
                                duration: const Duration(microseconds: 5),
                                curve: Curves.bounceIn,
                              );
                            }
                          },
                  ),
                ),
              ],
            ),
            AppSize.doubleSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}
