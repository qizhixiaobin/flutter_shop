import 'package:dio/dio.dart';
import 'package:flutter_shop/contants/GlobalConstants.dart';

class DioRequest {
  final Dio _dio = Dio();
  DioRequest() {
    _dio.options..baseUrl = GlobalConstants.API_BASE_URL
    ..connectTimeout = Duration(milliseconds: GlobalConstants.TIMEOUT_DURATION) // 5 seconds
    ..sendTimeout = Duration(milliseconds: GlobalConstants.TIMEOUT_DURATION) // 5 seconds
    ..receiveTimeout = Duration(milliseconds: GlobalConstants.TIMEOUT_DURATION); // 5 seconds

    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 请求前处理
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 响应后处理
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return handler.next(response);
        } else {
          return handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: '请求失败，状态码：${response.statusCode}',
          ));
        }
      },
      onError: (DioException e, handler) {
        // 错误处理
        handler.reject(DioException(requestOptions: e.requestOptions));
      },
    ));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    Response<dynamic> response = await task;
    final data = response.data;
    if (data['code'] == GlobalConstants.SUCCESS_CODE) {
      return data['result'];
    } else {
      throw Exception('请求失败，错误码：${data['code']}，错误信息：${data['message']}');
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}){
    try {
      return _handleResponse(_dio.get(path, queryParameters: queryParameters));
    } on DioException catch (e) {
      throw Exception('GET请求失败: ${e.message}');
    }
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
    try {
      return _handleResponse(_dio.post(path, data: data));
    } on DioException catch (e) {
      throw Exception('POST请求失败: ${e.message}');
    }
  }
}

final dioRequest = DioRequest();