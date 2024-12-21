import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AvatarNameWidget extends StatelessWidget {
  const AvatarNameWidget({super.key, this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Assets.icons.userCircle.svg(
            height: AppSize.mdImageSize * 1.4,
            width: AppSize.mdLoaderSize * 1.4,
          ),
          AppSize.spacing.widthBox,
          AppTitle(title: 'Welcome ${username ?? ""}'),
        ],
      ),
    );
  }
}
