import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

class AppMoreTile extends StatelessWidget {
  const AppMoreTile({
    super.key,
    required this.title,
    required this.leftIcon,
    this.widget,
    this.onPressed,
    this.hasLine = true,
    this.color,
    this.hasSize = false,
    this.fontWeight,
  });

  final String title;
  final Widget leftIcon;
  final Widget? widget;
  final VoidCallback? onPressed;
  final bool hasLine;
  final Color? color;
  final bool hasSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final defaultColor = context.colorScheme.onTertiary.withOpacity(.5);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.borderRadius),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: hasLine ? .2 : 0,
              color: hasLine
                  ? context.colorScheme.secondary.withOpacity(.1)
                  : Colors.transparent,
            ),
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
          splashColor: context.colorScheme.primary.withOpacity(.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  leftIcon,
                  AppSize.doubleSpacing.widthBox,
                  hasSize
                      ? AppTitle.h2(
                          title: title,
                          fontWeight: fontWeight ?? FontWeight.w400,
                          color: color ?? defaultColor,
                        )
                      : AppTitle(
                          title: title,
                          fontWeight: FontWeight.w400,
                          color: color ?? defaultColor,
                        ),
                ],
              ),
              Visibility(
                visible: widget == null ? false : true,
                child: widget != null ? widget! : const SizedBox(),
              ),
            ],
          ).paddingSymmetric(
            horizontal: AppSize.padding,
            vertical: AppSize.padding * 1.2,
          ),
        ),
      ),
    );
  }
}
