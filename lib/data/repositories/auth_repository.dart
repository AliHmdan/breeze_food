import 'dart:io';
import 'package:breezefood/linkapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class AuthRepository {
  // إعدادات عامة للـ Dio (مهلات + هيدرز + JSON)
  final Dio _dio = Dio(
    BaseOptions(
      // لو AppLink.* روابط كاملة، ما تحتاج baseUrl.
      // baseUrl: AppLink.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      // نخلي 4xx ما يرمي Exception؛ نخليه يرجع Response ونقرأ الرسالة بأنفسنا
      validateStatus: (status) => status != null && status < 500,
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      // لوج مفيد أثناء التطوير فقط
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

  // ===================== LOGIN =====================
  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        AppLink.login,
        data: {
          "identifier": phone,    // حسب API عندك
          "password": password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      // طباعة للمراجعة
      // debugPrint('${response.requestOptions.uri} -> ${response.statusCode}');
      // debugPrint('${response.data}');

      if (response.statusCode == 200) {
        return (response.data as Map).cast<String, dynamic>();
      }

      // 4xx: رجّع رسالة السيرفر إن وجدت
      final serverMsg = _extractMessage(response.data);
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: serverMsg ?? 'Login failed',
      );
    } on DioException catch (e) {
      // تمكين رسائل واضحة مع حالات انقطاع النت والمهلات
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('انتهت مهلة الاتصال أثناء تسجيل الدخول.');
      }
      if (e.error is SocketException) {
        throw Exception('لا يوجد اتصال بالإنترنت.');
      }
      rethrow; // يلتقطها الكيوبت ويعرض الرسالة
    }
  }

  // ===================== REGISTER =====================
  Future<Response> register({
    required String phone,
    required String password,
    required String confirmPassword,
    String? referralCode,
  }) async {
    try {
      // حضّر البيانات ولا ترسل referral_code إذا فاضي/Null
      final Map<String, dynamic> data = {
        "phone": phone,
        "password": password,
        "password_confirmation": confirmPassword,
      };
      final rc = referralCode?.trim();
      if (rc != null && rc.isNotEmpty) {
        data["referral_code"] = rc;
      }

      final response = await _dio.post(
        AppLink.signup,
        data: data,
        options: Options(contentType: Headers.jsonContentType),
      );

      // لو بدك تفشل صراحة على 4xx، خلّي الكيوبت يتعامل مع الرسالة
      // هنا نرجّع Response كما هو (الكود عندك يتوقع Response)
      return response;
    } on DioException catch (e) {
      // نفس المعالجة الذكية للأخطاء
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        rethrow; // الكيوبت سيحوّلها لرسالة "انتهت مهلة الاتصال..."
      }
      if (e.error is SocketException) {
        rethrow; // سيحوّلها الكيوبت لرسالة "لا يوجد اتصال..."
      }
      rethrow;
    }
  }

  // ===================== VERIFY PHONE =====================
  Future<Response> verifyPhone({
    required String phone,
    required String code,
  }) async {
    final data = {
      "phone": phone,
      "code": code,
    };

    return await _dio.post(
      AppLink.verifyPhone,
      data: data,
      options: Options(contentType: Headers.jsonContentType),
    );
  }

  // ===================== RESEND CODE =====================
  Future<Response> resendCode({required String phone}) async {
    return await _dio.post(
      AppLink.resendCode,
      data: {"phone": phone},
      options: Options(contentType: Headers.jsonContentType),
    );
  }

  // ===================== LOGOUT =====================
  Future<Response> logout({required String token}) async {
    return await _dio.post(
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

  // ===== Helper لاستخراج رسالة خطأ من الـ API إن وجدت =====
  String? _extractMessage(dynamic data) {
    if (data is Map) {
      final msg = data['message'] ?? data['error'] ?? data['msg'];
      return msg?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }
}
