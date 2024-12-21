import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/shared/components/app_image_container.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/domains/data.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class TransactionStarterTileWidget extends ConsumerWidget {
  const TransactionStarterTileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameColor = AppConstants.appColors.onSurface;
    final colorBox = AppConstants.appColors.primary;
    return SizedBox(
      height: AppSize.containerSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTitle.h4(
            title: AppString.rapidTransfer,
            fontWeight: FontWeight.w500,
          ),
          AppSize.spacing.heightBox,
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = data.elementAt(index);
              final userInitial = AppHelpers.generateInitial(
                name: user.surname,
                surname: user.name,
              );

              return Material(
                borderRadius: BorderRadius.circular(AppSize.borderRadius),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2.5,
                child: Container(
                  color: colorBox.withOpacity(.3),
                  width: AppSize.containerSize * 1.9,
                  child: Row(
                    children: [
                      Container(
                        width: AppSize.smContainerSize * 1.3,
                        decoration: BoxDecoration(
                          color: AppConstants.appColors.secondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.borderRadius),
                            bottomLeft: Radius.circular(AppSize.borderRadius),
                          ),
                        ),
                        child: AppTitle.h2(
                          title: userInitial,
                          fontWeight: FontWeight.bold,
                          color: nameColor,
                        ).toCenter(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTitle.h4(
                            title: "${user.name} ${user.surname}",
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppImageContainer(imageUrl: user.countryFlag, size: AppSize.imageSize,),
                              AppSize.spacing.widthBox,
                              AppTitle.h5(
                                title: user.countryName,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )
                        ],
                      ).paddingOnly(left: AppSize.padding),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: AppSize.halfPadding, vertical: AppSize.halfPadding/2,);
            },
          ).expanded(),
        ],
      ),
    ).paddingSymmetric(horizontal: AppSize.padding,);
  }
}
