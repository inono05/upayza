// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionRepositoryHash() =>
    r'f5718b551119abe13f346e92073db5dc0e52bb10';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider = Provider<TransactionRepository>.internal(
  transactionRepository,
  name: r'transactionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionRepositoryRef = ProviderRef<TransactionRepository>;
String _$transfersHash() => r'e9884bf0f6e8feb2771475a8633ef8a1cfaba974';

/// See also [transfers].
@ProviderFor(transfers)
final transfersProvider = FutureProvider<TransactionJSonResponse>.internal(
  transfers,
  name: r'transfersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$transfersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransfersRef = FutureProviderRef<TransactionJSonResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
