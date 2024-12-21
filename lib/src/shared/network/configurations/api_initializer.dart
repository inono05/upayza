import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/shared/network/api/api.dart';
import 'package:upayza/src/shared/network/interceptors/token_interceptor.dart';
import 'api_routes.dart';
import 'dio_initializer.dart';


part 'api_initializer.g.dart';

@Riverpod(keepAlive: true)
Api api(ApiRef ref) {
  return Api(
    baseUrl: ApiRoutes.baseUrl,
    DioInitializer().initialize(
      interceptors: [
        TokenInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        )
      ],
    ),
  );
}

