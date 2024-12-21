import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.searchDropdownController,
    required this.onChanged,
    required this.searchMatchFn,
    required this.icon,
    required this.value,
  });

  final String hintText;
  final List<DropdownMenuItem<dynamic>> items;
  final TextEditingController searchDropdownController;
  final ValueChanged onChanged;
  final bool Function(DropdownMenuItem, String) searchMatchFn;
  final Widget icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      hint: Text(
        hintText,
        style: context.headlineMedium,
      ),
      decoration: InputDecoration(prefixIcon: icon),
      items: items,
      value: value,
      onChanged: onChanged,
      onSaved: (value) {},
      iconStyleData: const IconStyleData(icon: Icon(Iconsax.arrow_down_14)),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        elevation: 4,
      ),

      dropdownSearchData: DropdownSearchData(
        searchController: searchDropdownController,
        searchInnerWidgetHeight: AppSize.btnSize,
        searchInnerWidget: AppFormField(
          hintText: T(context).search,
          controller: searchDropdownController,
        ).paddingSymmetric(
          horizontal: AppSize.halfPadding,
          vertical: AppSize.halfPadding,
        ),
        searchMatchFn: searchMatchFn,
      ),

      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          searchDropdownController.clear();
        }
      },
    ).paddingSymmetric(horizontal: AppSize.padding);
  }
}
