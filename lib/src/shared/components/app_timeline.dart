import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class AppTimeline extends StatelessWidget {
  const AppTimeline({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.child,
  });

  final bool isFirst;
  final bool isLast;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: AppSize.tripleSpacing,
          height: AppSize.tripleSpacing,
          color: context.colorScheme.primary,
          indicator: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.primary,
            ),
            child: const Center(
              child: Icon(Iconsax.activity),
            ),
          ),
        ),
        afterLineStyle: LineStyle(
          thickness: 1,
          color: context.colorScheme.primary,
        ),
        beforeLineStyle: LineStyle(
          thickness: 1,
          color: context.colorScheme.primary,
        ),
        endChild: child,
      ),
    );
  }
}
