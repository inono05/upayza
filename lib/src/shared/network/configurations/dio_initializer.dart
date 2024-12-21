import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'api_routes.dart';

class DioInitializer {
  Dio initialize({List<Interceptor> interceptors = const []}) {
    final dio = Dio()
      ..options.baseUrl = ApiRoutes.baseUrl
      ..interceptors.addAll(interceptors);
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () => HttpClient()
          ..badCertificateCallback = (
            X509Certificate cert,
            host,
            port,
          ) =>
              true;

    return dio;
  }
}
