import 'dart:convert';
import 'dart:io';

import 'package:breezefood/blocs/auth/login/login_event.dart';
import 'package:breezefood/blocs/auth/login/login_state.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    // 1) تنظيف الرقم
    final raw = event.phone.trim();
    if (raw.isEmpty) {
      emit(const LoginFailure('أدخل رقم الهاتف'));
      return;
    }

    final phoneDigits = _digitsOnly(raw);
    if (phoneDigits.length < 9) {
      emit(const LoginFailure('رقم الهاتف يجب أن لا يقل عن 9 محارف.'));
      return;
    }

    // إن كان الباك إند يقبل محلياً اتركه كما هو، وإلا طبّق قواعد E.164 هنا
    final normalizedPhone = phoneDigits;

    emit(LoginLoading());

    try {
      // 2) طلب تسجيل الدخول بالهاتف
      // تأكد أن عندك:
      // Future<Map<String, dynamic>> loginWithPhone(String phone)
      final Map<String, dynamic> resp =
          await authRepository.loginWithPhone(normalizedPhone);

      // 3) فحص التوكن
      final token = resp['token'];
      final user = resp['user'];

      // ✅ مسار تسجيل مباشر (يوجد توكن)
      if (token != null && token.toString().isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());
        if (user != null) {
          await prefs.setString('user', jsonEncode(user));
        }
        emit(LoginSuccess(resp));
        return;
      }

      // ✅ لا يوجد توكن = مسار OTP بغض النظر عن صيغة الرد
      emit(LoginOtpSent(
        // إذا رجع السيرفر الهاتف نأخذه، وإلا نستخدم المدخل
        (resp['phone']?.toString().trim().isNotEmpty ?? false)
            ? resp['phone'].toString().trim()
            : normalizedPhone,
      ));
      return;
    } on DioException catch (e) {
      // مهلات
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(const LoginFailure('انتهت مهلة الاتصال. تحقق من الشبكة.'));
        return;
      }

      // لا يوجد إنترنت
      if (e.error is SocketException) {
        emit(const LoginFailure('لا يوجد اتصال بالإنترنت.'));
        return;
      }

      // رسالة السيرفر إن وُجدت
      final msg = _extractMessage(e.response?.data) ?? 'خطأ في الاتصال';
      emit(LoginFailure(msg));
    } catch (e) {
      emit(const LoginFailure('حدث خطأ غير متوقع'));
    }
  }

  // إبقاء الدوال المساعدة كما هي
  String _digitsOnly(String input) {
    final b = StringBuffer();
    for (final ch in input.runes) {
      final c = String.fromCharCode(ch);
      final code = c.codeUnitAt(0);
      if (code >= 48 && code <= 57) {
        b.write(c);
      }
    }
    return b.toString();
  }

  String? _extractMessage(dynamic data) {
    if (data is Map) {
      final m = data['message'] ?? data['error'] ?? data['msg'] ?? data['status'];
      return m?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }
}
