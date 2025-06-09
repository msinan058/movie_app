import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_app/core/init/logger/logger_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/core/init/navigation/go_router.dart';
import 'package:movie_app/core/init/network/token_service.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();
  static NetworkManager get instance => _instance;
  NetworkManager._init();

  static const String _baseUrl = 'https://caseapi.servicelabs.tech';
  static const String _tokenKey = 'auth_token';
  final _storage = const FlutterSecureStorage();

  late final Dio dio;

  Future<void> setup() async {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        responseType: ResponseType.json,
        validateStatus: (status) => status! < 500,
      ),
    )..interceptors.addAll([
        _AuthInterceptor(),
        _LoggerInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      ]);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remember_me');
    await prefs.remove('remembered_email');
    await prefs.remove('remembered_password');
  }
}

class _AuthInterceptor extends Interceptor {
  final _tokenService = TokenService.instance;

  void _showErrorMessage() {
    final context = goRouter.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Oturum süreniz dolmuştur. Lütfen tekrar giriş yapın.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.data is Map<String, dynamic> &&
        _tokenService.isTokenError(err.response?.data['response'])) {
      try {
        await _tokenService.deleteToken();
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showErrorMessage();
          Future.delayed(
            const Duration(milliseconds: 300),
            () => goRouter.pushReplacement('/login'),
          );
        });
      } catch (_) {}
    }
    handler.next(err);
  }
}

class _LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerManager.instance.info('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LoggerManager.instance.info(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerManager.instance.error(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      err.error,
      err.stackTrace,
    );
    super.onError(err, handler);
  }
}

// Network exceptions
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  NetworkException({
    required this.message,
    this.statusCode,
    this.error,
  });

  @override
  String toString() => message;
}

// Network response model
class NetworkResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;

  NetworkResponse({
    this.data,
    this.message,
    required this.success,
    this.statusCode,
  });

  factory NetworkResponse.success(T data, {int? statusCode}) {
    return NetworkResponse(
      data: data,
      success: true,
      statusCode: statusCode,
    );
  }

  factory NetworkResponse.error(String message, {int? statusCode, dynamic error}) {
    return NetworkResponse(
      message: message,
      success: false,
      statusCode: statusCode,
    );
  }
} 