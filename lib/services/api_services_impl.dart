import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/services/api_services.dart';

var apiServiceProvider = Provider<ApiService>((ref) => ApiServiceImpl());

class ApiServiceImpl implements ApiService {
  Dio dio = Dio();

  @override
  void initializeApiServices() async {
    try {
      var options = BaseOptions(
          baseUrl: "",
          followRedirects: false,
          connectTimeout: 500000,
          validateStatus: (status) {
            return status! < 400;
          });

      dio = Dio(options);

      dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));

      log("ApiServices initialize Successfully");
    } catch (e) {
      log("initializeApiServices Error: $e");
    }
  }

  @override
  Future postRequest({
    bool isHeaderIncluded = false,
    bool isMultipart = false,
    bool isAcceptJson = false,
    CancelToken? cancelToken,
    required String endpoint,
    Map<String, dynamic>? headers,
    bool isXWwwForm = false,
    bool isStringRequest = false,
    dynamic data,
  }) async {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }

    if (isHeaderIncluded) {
      dio.options.headers['Content-Type'] = 'application/json';
    } else if (isMultipart) {
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      data = FormData.fromMap(data);
    } else if (isXWwwForm) {
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    } else if (isAcceptJson) {
      dio.options.headers['Accept'] = 'application/json';
    }

    try {
      final response = await dio.post(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        // options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return response;
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

  @override
  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    if (queryParameters != null) {
      dio.options.queryParameters.addAll(queryParameters);
    }

    try {
      final response = await dio.get(
        endpoint,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }
}
