import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/request_type.dart';

class DioClient {
  static final _dioClient = DioClient._();
  late final Dio _dio;
  static late String token;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._() {
    token = "";
    _dio = Dio();
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
          requestBody: true,
        ),
      );
    }
  }
  final timeOutDuration = const Duration(seconds: kDebugMode ? 100 : 60);

  Future<Response> request({
    required RequestType requestType,
    required String url,
    dynamic parameters,
    Map<String, dynamic>? queryParameters,
  }) async {
    Map<String, String> heading = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    switch (requestType) {
      case RequestType.get:
        return _dio
            .get(
              url,
              options: Options(headers: heading),
              queryParameters: queryParameters,
            )
            .timeout(
              timeOutDuration,
            );
      case RequestType.post:
        return _dio
            .post(
              url,
              data: jsonEncode(parameters),
              options: Options(headers: heading),
              queryParameters: queryParameters,
            )
            .timeout(
              timeOutDuration,
            );
      default:
        return _dio.get(url);
    }
  }
}
