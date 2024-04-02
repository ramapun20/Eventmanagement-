import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/utils/constants/endpoints.dart';
import 'package:flutter/material.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "Authorization";
const String defaultLanguage = "language";
const String xRequestedWith = "X-Requested-With";
const String xmlHttpRequest = "XMLHttpRequest";

Duration timeOut = const Duration(minutes: 2); // two minute

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = Endpoints.baseUrl;
    _dio.options.connectTimeout = timeOut;
    _dio.options.receiveTimeout = timeOut;
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
  }

  Future<Response<dynamic>> get(String url) async {
    try {
      return await _dio.get(url);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<dynamic>> post(String url, dynamic data) async {
    try {
      _dio.options.headers = {
        contentType: applicationJson,
        accept: applicationJson,
        authorization: "Bearer ${await kPref.getAccessToken()}",
      };
      return await _dio.post(url, data: data);
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Timeout occurred while sending or receiving";
      // case DioExceptionType.badResponse:
      //   return "Bad response";
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        return "No Internet Connection";
      case DioExceptionType.badCertificate:
        return "Internal Server Error";
      case DioExceptionType.connectionError:
        return "Connection Error";
      default:
        return "Unknown Error";
    }
    return "Unknown Error";
  }
}
