import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/Idioms/domains/idiom.dart';
import 'package:upayza/src/features/Idioms/presentation/controllers/idiom_controller.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class IdiomTileWidget extends StatelessWidget {
  const IdiomTileWidget({
    super.key,
    required this.idiom,
  });

  final Idiom idiom;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedIdiomCode = ref.watch(idiomControllerProvider);
        return Material(
          elevation: .02,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
          child: Container(
            height: AppSize.xsContainerSize,
            margin: const EdgeInsets.only(bottom: AppSize.halfPadding),
            foregroundDecoration: BoxDecoration(
              color: Colors.grey.withOpacity(selectedIdiomCode == idiom.code ? 0 : 1),
              backgroundBlendMode: BlendMode.saturation,
              borderRadius: BorderRadius.circular(
                AppSize.borderRadius,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CachedNetworkImage(
                  imageUrl: idiom.flag,
                  imageBuilder: (context, imageProvider) => Material(
                    elevation: 15.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(AppSize.borderRadius/1.2),
                    child: Container(
                      height: AppSize.spacing * 6,
                      width: AppSize.spacing * 8.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.borderRadius/1.2),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SpinKitRipple(
                    color: context.colorScheme.secondary,
                  ),
                  errorWidget: (context, url, error) => const Icon(Iconsax.watch),
                ),
                /*AppTitle.h5(
                  title: idiom.title,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.secondary,
                ),*/
              ],
            ).toCenter(),
          ),
        );
      },
    )
        .paddingSymmetric(
          horizontal: AppSize.halfPadding,
        )
        .animate()
        .flip(
          duration: 150.ms,
          curve: Curves.easeIn,
        );
  }
}
