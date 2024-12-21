import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/constants/app_colors_scheme.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class AppImageContainer extends ConsumerWidget {
  const AppImageContainer({
    super.key,
    required this.imageUrl,
    this.size,
    this.isRounded = true,
  });

  final String imageUrl;
  final double? size;
  final bool isRounded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isRounded
        ? CircleAvatar(
            backgroundColor: AppColorsScheme.lightColorScheme.background,
            radius: size ?? AppSize.borderRadius / 2,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              placeholder: (context, url) => SpinKitRipple(
                color: context.colorScheme.secondary,
              ),
              errorWidget: (context, url, error) => const Icon(Iconsax.trash1),
            ),
          )
        : Container(
            height: size! * 1.25,
            width: size! * 2,
            decoration: BoxDecoration(
              color: AppColorsScheme.lightColorScheme.background,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => SpinKitRipple(
                color: context.colorScheme.secondary,
              ),
              errorWidget: (context, url, error) => const Icon(Iconsax.trash1),
            ),
          );
  }
}
