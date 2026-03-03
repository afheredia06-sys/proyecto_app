// lib/services/api/agrillux_api_client.dart
import 'package:dio/dio.dart'; // CORRECTO
import 'package:flutter/foundation.dart';

class AgrilluxApiClient {
  static final AgrilluxApiClient _instance = AgrilluxApiClient._internal();
  factory AgrilluxApiClient() => _instance;
  AgrilluxApiClient._internal();

  late Dio _dio;
  final String baseUrl = 'https://tu-api-agrillux.com/api'; // URL de tu API

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors para logging en desarrollo
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('📤 Request: ${options.method} ${options.path}');
            if (options.data != null) print('📤 Data: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('📥 Response: ${response.statusCode}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            print('❌ Error: ${error.message}');
            if (error.response != null) {
              print('❌ Status: ${error.response?.statusCode}');
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Métodos HTTP genéricos
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Manejo de errores
  Exception _handleError(DioException error) {
    String message = 'Error en la petición';

    if (error.response != null) {
      // El servidor respondió con error
      message =
          'Error ${error.response?.statusCode}: ${error.response?.data?['message'] ?? error.response?.data}';
    } else if (error.type == DioExceptionType.connectionTimeout) {
      message = 'Tiempo de conexión agotado';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      message = 'Tiempo de recepción agotado';
    } else if (error.type == DioExceptionType.cancel) {
      message = 'Petición cancelada';
    } else {
      message = 'Error de conexión: ${error.message}';
    }

    return Exception(message);
  }
}
