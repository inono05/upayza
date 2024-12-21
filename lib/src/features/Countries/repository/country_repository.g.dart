// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countryRepositoryHash() => r'1ece33915b7b97e62dfbef18c135741283858509';

/// See also [countryRepository].
@ProviderFor(countryRepository)
final countryRepositoryProvider = Provider<CountryRepository>.internal(
  countryRepository,
  name: r'countryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$countryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CountryRepositoryRef = ProviderRef<CountryRepository>;
String _$countriesHash() => r'9c31749daa12bcf9e33b1dae6d89b5dc3ab1fc84';

/// See also [countries].
@ProviderFor(countries)
final countriesProvider = FutureProvider<CountriesJSonResponse>.internal(
  countries,
  name: r'countriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CountriesRef = FutureProviderRef<CountriesJSonResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
