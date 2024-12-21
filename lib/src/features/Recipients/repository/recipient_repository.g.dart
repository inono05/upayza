// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipient_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipientRepositoryHash() =>
    r'88721e1cb8adeab08cb4f5177950758b89a54524';

/// See also [recipientRepository].
@ProviderFor(recipientRepository)
final recipientRepositoryProvider = Provider<RecipientRepository>.internal(
  recipientRepository,
  name: r'recipientRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipientRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecipientRepositoryRef = ProviderRef<RecipientRepository>;
String _$recipientsHash() => r'41c78f84bd108770fd13f46f55e9f97ed4fbdf5a';

/// See also [recipients].
@ProviderFor(recipients)
final recipientsProvider = FutureProvider<RecipientJSonResponse>.internal(
  recipients,
  name: r'recipientsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$recipientsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecipientsRef = FutureProviderRef<RecipientJSonResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
