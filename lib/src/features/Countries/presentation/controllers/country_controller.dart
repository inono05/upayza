import 'package:riverpod/riverpod.dart';
import 'package:upayza/src/features/Countries/domains/country.dart';
import 'package:upayza/src/features/Countries/repository/country_repository.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

final searchedCountryProvider = StateProvider<String>((ref) => "");
final countryProvider = StateProvider<Country?>((ref) => null);

final userCountryProvider = StateProvider<Country?>((ref) {
  final List<Country> countries = ref.watch(countriesProvider).maybeWhen(
        data: (data) => data.countries!,
        orElse: () => [],
      );

  if (AppUserPreferences().countryId() == null) {
    return null;
  }
  return countries.firstWhere((e) => e.id! == AppUserPreferences().countryId());
});


final filteredCountryProvider = Provider<List<Country>>((ref) {
  final List<Country> countries = ref.watch(countriesProvider).maybeWhen(
        data: (data) => data.countries!,
        orElse: () => [],
      );
  final countrySearched = ref.watch(searchedCountryProvider);
  if (countrySearched.isEmpty) {
    return countries;
  }
  return countries
      .where(
        (e) => e.label!.toLowerCase().contains(
              countrySearched.toLowerCase(),
            ),
      )
      .toList();
});
