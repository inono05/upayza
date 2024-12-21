import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Profile/presentation/widgets/gender_form_radio_widget.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController uuidController = TextEditingController();
  final bool isMen = false, isFemale = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSize.spacing.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: [
                  const Icon(Iconsax.arrow_left).onTap(() => context.pop()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTitle(title: T(context).more),
                      const AppTitle.h4(title: "Update Profile"),
                    ],
                  )
                ],
              ),
              AppSize.tripleSpacing.heightBox,
              Container(
                alignment: Alignment.center,
                child: Assets.icons.editProfile
                    .svg(
                      color: context.colorScheme.secondary,
                      height: AppSize.iconSize * 3,
                      width: AppSize.iconSize * 3,
                    )
                    .paddingSymmetric(
                      vertical: AppSize.halfPadding,
                    ),
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    AppFormField(
                      controller: nameController,
                      labelText: "Name",
                      prefixIcon: AppFormIcon(
                        icon: Assets.icons.userSquare.svg(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                    AppFormField(
                      controller: usernameController,
                      labelText: "Username",
                      prefixIcon: AppFormIcon(
                        icon: Assets.icons.userSquare.svg(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                    AppFormField(
                      controller: dobController,
                      labelText: "Date of birth",
                      prefixIcon: AppFormIcon(
                        icon: Assets.icons.iconlyLightCalendar.svg(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                    const GenderFormRadioWidget(),
                    AppFormField(
                      controller: addressController,
                      labelText: "Address",
                      prefixIcon: AppFormIcon(
                        icon: Assets.icons.iconlyLightLocation.svg(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                    AppFormField(
                      controller: phoneController,
                      labelText: "Phone",
                      prefixIcon: AppFormIcon(
                        icon: Assets.icons.smartPhone.svg(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                    AppFormField(
                      controller: uuidController,
                      readOnly: true,
                      labelText: "Identifier",
                      prefixIcon: AppFormIcon(
                        icon: Assets.icons.userSquare.svg(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                    AppSize.tripleSpacing.heightBox,
                    AppButton(
                      title: "Update",
                      onPressed: () {},
                    )
                  ],
                ),
              ).paddingSymmetric(
                horizontal: AppSize.padding,
                vertical: AppSize.padding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
