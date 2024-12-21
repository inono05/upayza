import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLoggerObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is StateController && previousValue is StateController) {
      log(
        '''
          {
            "provider": "${provider.name ?? provider.runtimeType}",
            "newValue": "$newValue",
            "previous value": "${previousValue.state}"
          }''',
      );
    }
  }
}
