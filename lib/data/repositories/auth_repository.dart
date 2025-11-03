import 'package:freeza_food/linkapi.dart';
import 'package:dio/dio.dart';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository() {
    // لو عندك توكن محفوظ مسبقًا، فيك تفعّل تحميله تلقائيًا هنا:
    _bootstrapAuthHeader();
  }

  final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl:
                'https://syriansociety.org/api', // المسار الأساسي لاستدعاءات /me
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            // نسمح بقراءة 4xx بدل رمي استثناء فوري
            validateStatus: (status) => status != null && status < 500,
            responseType: ResponseType.json,
          ),
        )
        ..interceptors.addAll([
          if (kDebugMode)
            LogInterceptor(
              request: true,
              requestHeader: true,
              requestBody: true,
              responseHeader: false,
              responseBody: true,
              error: true,
            ),
        ]);

  // ========= Authorization Header =========
  void setAuthHeader(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthHeader() {
    _dio.options.headers.remove('Authorization');
  }

  Future<void> _bootstrapAuthHeader() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null && token.isNotEmpty) {
        setAuthHeader(token);
      }
    } catch (_) {
      // تجاهل أي خطأ قراءة محلي
    }
  }

  // ========= PROFILE (/api/me) =========
  Future<Response> getMe() async {
    // يستعمل baseUrl + '/me'
    return _dio.get('/me');
  }

  /// حدّث البيانات الشخصية. لو باك إندك يستخدم مسار مختلف غيّره هنا فقط.
  Future<Response> updateMe({
    String? firstName,
    String? lastName,
    String? email,
    String? birthday, // بصيغة YYYY-MM-DD
  }) async {
    final body = <String, dynamic>{
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (birthday != null) 'birthday': birthday,
    };
    return _dio.patch('/me', data: body);
  }

  // ========= LOGIN (قديم - اختياري) =========
  Future<Map<String, dynamic>> login(String phone) async {
    try {
      final response = await _dio.post(
        AppLink.login, // يقبل رابط كامل أو نسبي
        data: {
          "phone": phone,
          // "password": password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (_is2xx(response.statusCode)) {
        return _asMap(response.data);
      }

      final serverMsg = _extractMessage(response.data);
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: serverMsg ?? 'Login failed',
      );
    } on DioException catch (e) {
      if (_isTimeout(e))
        throw Exception('انتهت مهلة الاتصال أثناء تسجيل الدخول.');
      if (e.error is SocketException)
        throw Exception('لا يوجد اتصال بالإنترنت.');
      rethrow;
    }
  }

  // ========= LOGIN WITH PHONE (جديد) =========
  Future<Map<String, dynamic>> loginWithPhone(String phone) async {
    try {
      final response = await _dio.post(
        AppLink.login, // تأكد أنه يشير لنقطة نهاية تسجيل/OTP المناسبة
        data: {"phone": phone},
        options: Options(contentType: Headers.jsonContentType),
      );

      final data = _asMap(response.data);

      // نجاح فعلي (توكن/يوزر) أو نجاح منطقي (otp_sent) ضمن 2xx
      if (_is2xx(response.statusCode)) return data;

      // أحياناً 4xx مع رسالة مفيدة
      final serverMsg = _extractMessage(data);
      if (serverMsg != null && serverMsg.isNotEmpty) {
        return data; // اترك قرار الملاحة للبلوك
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'Login with phone failed',
      );
    } on DioException catch (e) {
      if (_isTimeout(e))
        throw Exception('انتهت مهلة الاتصال أثناء تسجيل الدخول.');
      if (e.error is SocketException)
        throw Exception('لا يوجد اتصال بالإنترنت.');
      rethrow;
    }
  }

  // ========= REGISTER =========
  Future<Response> register({
    required String phone,
    required String password,
    required String confirmPassword,
    String? referralCode,
  }) async {
    try {
      final data = <String, dynamic>{
        "phone": phone,
        "password": password,
        "password_confirmation": confirmPassword,
      };
      final rc = referralCode?.trim();
      if (rc != null && rc.isNotEmpty) data["referral_code"] = rc;

      final response = await _dio.post(
        AppLink.signup,
        data: data,
        options: Options(contentType: Headers.jsonContentType),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ========= VERIFY PHONE / RESEND =========
  Future<Response> verifyPhone({
    required String phone,
    required String code,
  }) async {
    return _dio.post(
      AppLink.verifyPhone,
      data: {"phone": phone, "code": code},
      options: Options(contentType: Headers.jsonContentType),
    );
  }

  // ========= UPDATE PROFILE (/api/updateProfile) =========
  /// Some backends expect a POST to /api/updateProfile with first_name/last_name
  /// and require Authorization header (Bearer token). This helper posts the
  /// provided fields and returns the raw Response for callers to inspect.
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
  }) async {
    final body = {'first_name': firstName, 'last_name': lastName};

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
      final resp = await _dio.post(
        AppLink.updateProfile,
        data: body,

        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
      return resp;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> resendCode({required String phone}) async {
    return _dio.post(
      AppLink.resendCode,
      data: {"phone": phone},
      options: Options(contentType: Headers.jsonContentType),
    );
  }

  // ========= LOGOUT =========
  Future<Response> logout({required String token}) async {
    return _dio.post(
      AppLink.logout,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        contentType: Headers.jsonContentType,
      ),
    );
  }

  // ========= Helpers =========
  bool _is2xx(int? code) => code != null && code >= 200 && code < 300;

  bool _isTimeout(DioException e) =>
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout;

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return data.cast<String, dynamic>();
    return {'message': data?.toString() ?? 'unknown_response'};
  }

  String? _extractMessage(dynamic data) {
    if (data is Map) {
      final msg =
          data['message'] ?? data['error'] ?? data['msg'] ?? data['status'];
      return msg?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }
}
