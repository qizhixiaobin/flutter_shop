import 'package:dio/dio.dart';
import 'package:flutter_shop/contants/GlobalConstants.dart';
import 'package:flutter_shop/stores/TokenManager.dart';

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
        // 注入token
        final token = tokenManager.getToken();
        if (token.isNotEmpty) {
          options.headers = {
            "Authorization": "Bearer $token",
          };
        }
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
        handler.reject(DioException(requestOptions: e.requestOptions, message: e.response?.data['message'] ?? '请求发生错误'));
      },
    ));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> response = await task;
      final data = response.data;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        return data['result'];
      } else {
        throw DioException(requestOptions:  response.requestOptions, 
                           message: data['message'] ?? '请求失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}){

    return _handleResponse(_dio.get(path, queryParameters: queryParameters));
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
  
    return _handleResponse(_dio.post(path, data: data));
  }
}

final dioRequest = DioRequest();