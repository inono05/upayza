import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../constants/app_sizes.dart';
import 'app_title.dart';

class LogoutLoaderWidget extends StatelessWidget {
  const LogoutLoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Container(
        color: context.colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRipple(color: context.colorScheme.surface),
            AppSize.tripleSpacing.heightBox,
            AppTitle(
              title: "In Progress...",
              color: context.colorScheme.surface,
            )
          ],
        ).toCenter(),
      ),
    );
  }
}