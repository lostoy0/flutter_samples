import 'package:dio/dio.dart';
import 'package:flutter_samples/models/result_entity.dart';

class HttpClient {
  static HttpClient? _instance;

  static HttpClient instance() {
    _instance ??= HttpClient._();
    return _instance!;
  }

  final Dio _dio = Dio();

  HttpClient._() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
    );
  }

  Future<Response<ResultEntity<T>>> get<T>(String url,
      {Map<String, dynamic>? params}) async {
    return await _getOrPost<T>(url, params: params);
  }

  Future<Response<ResultEntity<T>>> post<T>(String url,
      {Map<String, dynamic>? params}) async {
    return await _getOrPost<T>(url, params: params, isGet: false);
  }

  Future<Response<ResultEntity<T>>> _getOrPost<T>(String url,
      {Map<String, dynamic>? params, bool isGet = true}) async {
    Response response;
    if (isGet) {
      response = await _dio.request(url,
          queryParameters: params, options: Options(method: 'GET'));
    } else {
      response = await _dio.request(url,
          data: params, options: Options(method: 'POST'));
    }
    Response<ResultEntity<T>> newResponse = Response(
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isRedirect: response.isRedirect,
        redirects: response.redirects,
        extra: response.extra,
        headers: response.headers);
    if (response.data != null) {
      newResponse.data = ResultEntity<T>.fromJson(response.data);
    }
    return newResponse;
  }

  Future<Response<T>> request<T>(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}
