import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/core/init/logger/logger_manager.dart';
import 'package:movie_app/core/init/network/network_manager.dart';

abstract class BaseService {
  final Dio dio = NetworkManager.instance.dio;
  final logger = LoggerManager.instance;

  Future<BaseResponseModel<T>> handleResponse<T>({
    required Future<Response<dynamic>> Function() requestFunction,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await requestFunction();
      
      if (response.statusCode == HttpStatus.ok || 
          response.statusCode == HttpStatus.created) {
        if (response.data is Map<String, dynamic>) {
          final data = fromJson(response.data as Map<String, dynamic>);
          return BaseResponseModel.success(
            data: data,
            statusCode: response.statusCode,
            headers: response.headers.map,
          );
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        return BaseResponseModel.error(
          message: 'Request failed with status: ${response.statusCode}',
          statusCode: response.statusCode,
          headers: response.headers.map,
        );
      }
    } on DioException catch (e) {
      logger.error('DioException', e, e.stackTrace);
      return _handleDioError(e);
    } catch (e, stackTrace) {
      logger.error('Unexpected error', e, stackTrace);
      return BaseResponseModel.error(
        message: e.toString(),
        statusCode: HttpStatus.internalServerError,
      );
    }
  }

  BaseResponseModel<T> _handleDioError<T>(DioException error) {
    String message;
    int? statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout';
        statusCode = HttpStatus.requestTimeout;
        break;
      case DioExceptionType.badResponse:
        // Handle both JSON and non-JSON responses
        if (error.response?.data is Map) {
          message = error.response?.data['message'] ?? 'Bad response';
        } else {
          message = 'Server error: ${error.response?.statusCode}';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        statusCode = HttpStatus.clientClosedRequest;
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection';
        statusCode = HttpStatus.serviceUnavailable;
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        statusCode = HttpStatus.forbidden;
        break;
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          message = 'No internet connection';
          statusCode = HttpStatus.serviceUnavailable;
        } else {
          message = 'Unexpected error occurred';
          statusCode = HttpStatus.internalServerError;
        }
        break;
    }

    return BaseResponseModel.error(
      message: message,
      statusCode: statusCode,
      headers: error.response?.headers.map,
      extra: error.response?.data is Map ? error.response?.data : null,
    );
  }

  // Helper methods for common HTTP methods
  Future<BaseResponseModel<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> json) fromJson,
    Options? options,
  }) async {
    return handleResponse<T>(
      requestFunction: () => dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  Future<BaseResponseModel<T>> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> json) fromJson,
    Options? options,
  }) async {
    return handleResponse<T>(
      requestFunction: () => dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  Future<BaseResponseModel<T>> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> json) fromJson,
    Options? options,
  }) async {
    return handleResponse<T>(
      requestFunction: () => dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      fromJson: fromJson,
    );
  }

  Future<BaseResponseModel<T>> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> json) fromJson,
    Options? options,
  }) async {
    return handleResponse<T>(
      requestFunction: () => dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      fromJson: fromJson,
    );
  }
} 