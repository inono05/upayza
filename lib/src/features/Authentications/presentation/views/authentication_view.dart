import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/features/Authentications/presentation/controllers/app_form_controller.dart';
import 'package:upayza/src/features/Authentications/presentation/widgets/tabs/login_tab_widget.dart';
import 'package:upayza/src/features/Authentications/presentation/widgets/tabs/register_tab_widget.dart';
import 'package:upayza/src/shared/components/app_authentication_header.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView>
    with SingleTickerProviderStateMixin {
  final tabs = const [Tab(text: "Sign In"), Tab(text: "Sign Up")];
  late TabController controllerTab;
  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppAuthenticationHeader(),
              TabBar(
                tabs: tabs,
                controller: controllerTab,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                labelStyle: context.textTheme.headlineLarge,
                onTap: (value) {
                   ref.invalidate(usePhoneProvider);
                   ref.invalidate(passwordVisibleProvider);
                },
              ),
              Expanded(
                child: TabBarView(
                  controller: controllerTab,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    LoginTabWidget(),
                    RegisterTabWidget(),
                  ],
                ),
              )
            ],
          ),
        ).paddingSymmetric(horizontal: AppSize.padding),
      ),
    );
  }
}
