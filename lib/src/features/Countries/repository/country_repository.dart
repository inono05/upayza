import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/features/Countries/domains/country_json_response.dart';
import 'package:upayza/src/shared/network/api/api.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';

part 'country_repository.g.dart';

class CountryRepository{
  final Api api;
 CountryRepository(this.api);

 Future<CountriesJSonResponse> loadCountries() {
   return api.countries();
 }
}

@Riverpod(keepAlive: true)
CountryRepository countryRepository (CountryRepositoryRef ref) {
  return CountryRepository(ref.watch(apiProvider));
}

@Riverpod(keepAlive: true)
Future<CountriesJSonResponse> countries(CountriesRef ref) async{
  return ref.watch(countryRepositoryProvider).loadCountries();
}
