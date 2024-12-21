import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:upayza/src/core/models/json_response.dart';

class AppExceptions{
  AppExceptions._();
  
  static String? message(dynamic exception){
    if (exception is FirebaseException) {
      return exception.message ?? exception.toString();
    }  
    if (exception is PlatformException) {
      return exception.message ?? exception.toString();
    }
    if (exception is DioException) {
      if ((exception).response != null) {
        final exceptionValue = JSonResponse.fromJson((exception).response?.data);
        return exceptionValue.message.toString();
      }
      return exception.message.toString() ;
    }
    return exception.toString();
  }
}