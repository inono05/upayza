import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/Countries/domains/country.dart';
import 'package:upayza/src/features/Countries/repository/country_repository.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/components/forms/app_dropdown_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_exceptions.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class CountryDropdownWidget extends ConsumerStatefulWidget {
  const CountryDropdownWidget({super.key});

  @override
  ConsumerState createState() => _CountryDropdownWidgetState();
}

class _CountryDropdownWidgetState extends ConsumerState<CountryDropdownWidget> {
  final TextEditingController searchController = TextEditingController();
  late String selectedCountry = "";
  @override
  Widget build(BuildContext context) {
    final countriesValues = ref.watch(countriesProvider);
    return countriesValues.when(
      data: (data) {
        final countries = data.countries;
        return SizedBox(
          height: 100,
          child: AppDropdownField(
            hintText: "Select your country",
            icon: const AppFormIcon(icon: Icon(Iconsax.global_edit)),
            items: countries!.map(
              (e) {
                return DropdownMenuItem<Country>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.label!,
                        style: context.headlineMedium,
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ).toList(),
            searchDropdownController: searchController,
            onChanged: (value) {
            },
            searchMatchFn: (item, searchValue) {
              return item.value!.otp.toLowerCase().contains(
                    searchValue.toLowerCase(),
                  );
            },
            value: "Cameroon",
          ),
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
      ),
    );
  }
}
