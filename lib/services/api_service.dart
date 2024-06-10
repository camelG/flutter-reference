import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class ApiService {
  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? '',
    connectTimeout: const Duration(seconds: 5), // 5秒
    receiveTimeout: const Duration(seconds: 3), // 3秒
    headers: {'Content-Type': 'application/json'},
  ));

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to load data: ${e.response?.statusCode}');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to post data: ${e.response?.statusCode}');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: jsonEncode(data),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to update data: ${e.response?.statusCode}');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to delete data: ${e.response?.statusCode}');
    }
  }
}
