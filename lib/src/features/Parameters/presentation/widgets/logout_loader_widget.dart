import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';

import '../../../../shared/components/app_title.dart';
import '../../../../shared/constants/app_sizes.dart';

class LogoutLoaderWidget {
  static show({required BuildContext context}) {
    return showDialog(context: context, builder: (context) {
      return SafeArea(
        top: false,
        bottom: false,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: context.height,
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
            )
        ),
      );
    });
  }


  static close({required BuildContext context}) {
    (context).router.pop();
  }
}
