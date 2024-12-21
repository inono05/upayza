import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upayza/src/features/Countries/repository/country_repository.dart';
import 'package:upayza/src/shared/components/app_alert_dialog.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_exceptions.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class CountryModalWidget extends ConsumerWidget {
  const CountryModalWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesValues = ref.watch(countriesProvider);
    return countriesValues.when(
      data: (data) {
        final countries = data.countries;
        return ListView.builder(
          itemCount: countries?.length,
          itemBuilder: (context, index) {
            final country = countries?.elementAt(index);
            return ListTile(
              title: Text(country!.label!),
            );
          },
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
