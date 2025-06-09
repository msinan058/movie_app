import 'package:equatable/equatable.dart';

class BaseResponseModel<T> extends Equatable {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? extra;

  const BaseResponseModel({
    this.data,
    this.message,
    this.success = false,
    this.statusCode,
    this.headers,
    this.extra,
  });

  factory BaseResponseModel.success({
    required T data,
    String? message,
    int? statusCode,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
  }) {
    return BaseResponseModel<T>(
      data: data,
      message: message,
      success: true,
      statusCode: statusCode,
      headers: headers,
      extra: extra,
    );
  }

  factory BaseResponseModel.error({
    String? message,
    int? statusCode,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
  }) {
    return BaseResponseModel<T>(
      message: message ?? 'An error occurred',
      success: false,
      statusCode: statusCode,
      headers: headers,
      extra: extra,
    );
  }

  BaseResponseModel<T> copyWith({
    T? data,
    String? message,
    bool? success,
    int? statusCode,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
  }) {
    return BaseResponseModel<T>(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      extra: extra ?? this.extra,
    );
  }

  @override
  List<Object?> get props => [data, message, success, statusCode, headers, extra];
} 