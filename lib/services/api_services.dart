import 'package:dio/dio.dart';

abstract class ApiService {
  // Initialize ApiServices
  initializeApiServices();

  //Post request
  Future<dynamic> postRequest({
    bool isHeaderIncluded = false,
    bool isMultipart = false,
    bool isAcceptJson = false,
    CancelToken? cancelToken,
    required String endpoint,
    Map<String, dynamic>? headers,
    bool isXWwwForm = false,
    bool isStringRequest = false,
    dynamic data,
  });

  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });
}
