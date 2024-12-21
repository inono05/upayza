import 'dart:developer';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/Countries/presentation/controllers/country_controller.dart';
import 'package:upayza/src/features/Countries/repository/country_repository.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/app_image_container.dart';
import 'package:upayza/src/shared/components/forms/app_form_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_exceptions.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

import '../../../../shared/components/app_title.dart';
import '../../domains/country.dart';

class CountryView extends ConsumerWidget {
  CountryView({
    super.key,
    this.isModalOpen = false,
  });

  final bool isModalOpen;
  final searchEditingController = TextEditingController();
  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsyncValue = ref.watch(countriesProvider);
    final filteredCountries = ref.watch(filteredCountryProvider);
    final myCountry = ref.watch(countryProvider);

    bool isCountrySelected(Country country) {
      final bool hasCountryValue = myCountry != null;
      if (hasCountryValue) {
        if (country.countryCode!.contains(myCountry.countryCode!)) {
          return true;
        }
      }
      return false;
    }

    return Scaffold(
      body: SafeArea(
        child: countriesAsyncValue.when(
          data: (data) {
            return Column(
              children: [
                (AppSize.tripleSpacing * 2).heightBox,
                Icon(
                  Iconsax.arrow_left,
                  color: context.colorScheme.primary,
                ).onTap(() {
                  if (isModalOpen) {
                    context.router.pop();
                  }
                }).alignAtCenterLeft(),
                (AppSize.doubleSpacing).heightBox,
                AppFormField(
                  labelText: "Search Your country",
                  controller: searchEditingController,
                  prefixIcon: const AppFormIcon(
                    icon: Icon(Iconsax.search_normal),
                  ),
                  onChanged: (value) {
                    log(value!);
                    ref.read(searchedCountryProvider.notifier).state = value;
                  },
                  onEditingComplete: () {},
                ),
                ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries.elementAt(index);
                    return ListTile(
                      leading: AppImageContainer(
                        imageUrl: country.flag!,
                        size: AppSize.spacing,
                      ),
                      title: AppTitle.h4(title: country.label!),
                      onTap: () {
                        ref
                            .read(countryProvider.notifier)
                            .update((state) => country);
                        if (isModalOpen) {
                          context.router.pop();
                        }
                      },
                      selectedColor: context.colorScheme.primary,
                      splashColor: context.colorScheme.primary.withOpacity(.2),
                      selected: (isCountrySelected(country)) ? true : false,
                      trailing: (isCountrySelected(country))
                          ? const Icon(Icons.check)
                          : const SizedBox.shrink(),
                    );
                  },
                ).expanded(),
              ],
            );
          },
          error: (error, s) => AppHelpers.showAlert(
            context: context,
            child: AppAlertDialog.error(
              message: AppExceptions.message(error)!,
            ),
          ),
          loading: () => SpinKitPianoWave(
            color: context.colorScheme.primary,
          ).toCenter(),
        ),
      ).paddingSymmetric(horizontal: AppSize.padding),
    );
  }
}
