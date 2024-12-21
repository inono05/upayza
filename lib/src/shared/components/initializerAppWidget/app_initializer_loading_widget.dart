import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upayza/src/core/theme/app_theme.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';



class AppInitializerLoadingWidget extends ConsumerWidget {
  const AppInitializerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRipple(color: context.colorScheme.surface, size: AppSize.doubleIconSize,),
            AppSize.tripleSpacing.heightBox,
            AppTitle.h4(
              title: "Initializing...",
              color: context.colorScheme.surface,
            )
          ],
        ),
      ),
    );
  }
}
