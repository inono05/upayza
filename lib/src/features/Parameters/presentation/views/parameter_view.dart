import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/features/Parameters/presentation/widgets/account_manager_widget.dart';
import 'package:upayza/src/features/Parameters/presentation/widgets/logout_widget.dart';
import 'package:upayza/src/features/Parameters/presentation/widgets/preferences_widget.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class ParameterView extends ConsumerWidget {
  const ParameterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSize.tripleSpacing.heightBox,
              AppTitle.h2(title: T(context).more),
              const AppTitle.h4(title: "Applications Settings"),
              AppSize.tripleSpacing.heightBox,
              AppTitle(
                title: "Account",
                color: context.colorScheme.onTertiary.withOpacity(.6),
                fontWeight: FontWeight.bold,
              ),
              AppSize.doubleSpacing.heightBox,
              const AccountManagerWidget(),
              AppSize.tripleSpacing.heightBox,
              AppTitle(
                title: "Preferences",
                color: context.colorScheme.onTertiary.withOpacity(.6),
                fontWeight: FontWeight.bold,
              ),
              AppSize.doubleSpacing.heightBox,
              const PreferencesWidget(),
              AppSize.tripleSpacing.heightBox,
              AppSize.spacing.heightBox,
              const LogoutWidget(),
              AppSize.tripleSpacing.heightBox,
            ],
          ),
        ).paddingAll(AppSize.padding),
      ),
    );
  }
}
