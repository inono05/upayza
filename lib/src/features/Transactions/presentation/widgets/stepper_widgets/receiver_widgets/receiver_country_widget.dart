import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Countries/domains/country.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/shared/components/app_image_container.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class ReceiverCountryWidget extends ConsumerWidget {
  const ReceiverCountryWidget({
    super.key,
    required this.mainAlignment,
    required this.country,
  });

  final MainAxisAlignment mainAlignment;
  final Country country;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.watch(recipientCountryProvider);
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1.8,
      borderRadius: BorderRadius.circular(
        AppSize.borderRadius,
      ),
      child: Container(
        height: AppSize.containerSize / .41,
        width: AppSize.containerSize * 1.3,
        decoration: BoxDecoration(
          color: identical(country, selectedCountry)
              ? AppConstants.appColors.primary.withOpacity(.82)
              : Colors.white,
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          color: Colors.grey
              .withOpacity(identical(country, selectedCountry) ? 0 : 1),
          backgroundBlendMode: BlendMode.saturation,
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: mainAlignment,
              children: [
                Material(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(
                    AppSize.borderRadius / 1.4,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSize.borderRadius / 1.4,
                    ),
                    child: AppImageContainer(
                      imageUrl: country.flag!,
                      size: AppSize.mdImageSize * 1.2,
                      isRounded: false,
                    ),
                  ),
                ),
                identical(country, selectedCountry)
                    ? Assets.icons.checkCircleSuccess.svg(
                        height: AppSize.doubleSpacing,
                        width: AppSize.doubleSpacing,
                        color: context.colorScheme.surface,
                      )
                    : const SizedBox.shrink()
              ],
            ),
            AppSize.spacing.heightBox,
            AppTitle.h5(
              title: country.label!,
              fontWeight: FontWeight.w600,
              color: identical(country, selectedCountry)
                  ? context.colorScheme.surface
                  : context.colorScheme.secondary,
            ).paddingSymmetric(
              horizontal: AppSize.halfPadding,
            ),
          ],
        ).paddingSymmetric(
          horizontal: AppSize.halfPadding,
        ),
      ),
    ).paddingSymmetric(
        horizontal: AppSize.halfPadding, vertical: AppSize.halfPadding / 2);
  }
}
