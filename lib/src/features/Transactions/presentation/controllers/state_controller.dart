import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/models/deposit_number_json_response.dart';
import 'package:upayza/src/core/models/gateway_json_response.dart';
import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/features/Countries/presentation/controllers/country_controller.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_json_response.dart';
import 'package:upayza/src/features/Recipients/repository/recipient_repository.dart';
import 'package:upayza/src/features/Transactions/domains/method_type.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';

import '../../../Countries/domains/country.dart';
import '../../../Countries/repository/country_repository.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);
final methodTypeProvider = StateProvider<MethodType?>((ref) => null);
//sender stateProvider
final senderGatewayProvider = StateProvider<Gateway?>((ref) => null);
final senderOperatorProvider = StateProvider<Operator?>((ref) => null);
final senderNumberProvider = StateProvider<String?>((ref) => null);
final senderAmountProvider = StateProvider<String?>((ref) => null);
final senderPurposeProvider = StateProvider<String?>((ref) => null);
final senderDepositNumberProvider =
    StateProvider<DepositNumber?>((ref) => null);
final senderFormatCountryProvider = StateProvider<CountryWithPhoneCode?>((ref) {
  final senderCountry = ref.watch(userCountryProvider);
  log("senderCountry ===> ${senderCountry.toString()}");

  return (senderCountry != null)
      ? CountryManager().countries.firstWhere((e) => e.phoneCode
          .toLowerCase()
          .contains(senderCountry.countryCode!.toLowerCase()))
      : null;
});

final isDepositNumberProvider = StateProvider<bool>((ref) => false);

//recipient stateProvider
final recipientCountryProvider = StateProvider<Country?>((ref) => null);
final recipientOperatorProvider = StateProvider<Operator?>((ref) => null);
final recipientNameProvider = StateProvider<String?>((ref) => null);
final recipientNumberProvider = StateProvider<String?>((ref) => null);
final recipientAmountProvider =
    StateProvider<String?>((ref) => ref.watch(senderAmountProvider));
final recipientFormatCountryProvider =
    StateProvider<CountryWithPhoneCode?>((ref) {
  final recipientCountry = ref.watch(recipientCountryProvider);
  return (recipientCountry != null)
      ? CountryManager().countries.firstWhere((e) => e.phoneCode
          .toLowerCase()
          .contains(recipientCountry.countryCode!.toLowerCase()))
      : null;
});

final recipientsListProvider = StateProvider<List<Recipient>>((ref) {
  return ref
      .watch(recipientsProvider)
      .maybeWhen(orElse: () => [], data: (data) => data.recipients);
});

final recipientSelectedProvider = StateProvider<Recipient?>((ref) => null);

/// State for adding, search a
/// recipient information to perform
/// the transaction

final searchReceiverTextProvider = StateProvider<String>((ref) => "");
final hasRecipientProvider = StateProvider<bool>((ref) => false);
final filteredRecipientsProvider = StateProvider<List<Recipient>>((ref) {
  final List<Recipient> recipients = ref.watch(recipientsProvider).maybeWhen(
        orElse: () => [],
        data: (data) => data.recipients,
      );
  final query = ref.watch(searchReceiverTextProvider);
  if (query.isEmpty) {
    return recipients;
  }
  return recipients
      .where((m) =>
          m.firstName!.toLowerCase().contains(query.toLowerCase()) ||
          m.number!.toLowerCase().removeAllWhitespace.contains(query.toLowerCase()) ||
          m.lastName!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

final selectedRecipientProvider = StateProvider<Recipient>((ref) {
  final List<Recipient> recipients = ref.watch(recipientsProvider).maybeWhen(
        orElse: () => [],
        data: (data) => data.recipients,
      );
  final query = ref.watch(recipientNumberProvider);
  return recipients.firstWhere(
      (m) => m.number!.toLowerCase().contains(query!.toLowerCase()));
});


//transaction result state
final transferResponseProvider = StateProvider<TransactionObjectJSonResponse?>((ref) => null);
final filterCountryProvider = StateProvider<String>((ref) => "");
final recipientCountriesProvider = Provider<List<Country>>((ref) {
  final List<Country> countries = ref.watch(countriesProvider).maybeWhen(
    data: (data) => data.countries!,
    orElse: () => [],
  );
  final countrySearched = ref.watch(filterCountryProvider);
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
