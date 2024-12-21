import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final token = AppUserPreferences().token();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.contentType = "application/json";
    options.connectTimeout = 5000.ms;
    options.receiveTimeout = 5000.ms;
    options.headers[HttpHeaders.acceptHeader] = "application/json";
    options.headers[HttpHeaders.acceptCharsetHeader] = "charset=UTF-8";
    final token = AppUserPreferences().token();
    if (token != null) {
      log('token => $token');
      options.headers[HttpHeaders.authorizationHeader] = token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      //Todo implement the login redirection method
      //use the app_service to get the global context
    }
    super.onError(err, handler);
  }
}
