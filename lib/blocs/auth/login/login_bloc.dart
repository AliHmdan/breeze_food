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
    // تحقق أساسي قبل النداء
    final phone = event.phone.trim();
    final password = event.password.trim();

    if (phone.isEmpty) {
      emit(const LoginFailure('أدخل رقم الهاتف'));
      return;
    }
    if (password.isEmpty) {
      emit(const LoginFailure('أدخل كلمة المرور'));
      return;
    }

    emit(LoginLoading());

    try {
      // 👇 ملاحظة مهمة:
      // الـ API عندك يستقبل "identifier" وليس "phone" (كما في AuthRepository.login)
      // ولو حابب توحّد الصيغة الدولية E.164 أضف +963 هنا إن كان لازم.
      final normalizedIdentifier = phone; // أو '+963$phone' حسب باك إندك

      final Map<String, dynamic> resp = await authRepository.login(
        normalizedIdentifier,
        password,
      );

      // نتوقع شيئًا مثل: { "token": "....", "user": {...} } أو رسالة فشل
      final token = resp['token'];
      final user = resp['user'];

      if (token != null && token.toString().isNotEmpty) {
        // خزّن التوكن واليوزر
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());
        if (user != null) {
          await prefs.setString('user', jsonEncode(user));
        }

        emit(LoginSuccess(resp));
      } else {
        // إن لم يوجد توكن نقرأ رسالة الخادم (إن وجدت)
        final serverMsg = _extractMessage(resp) ?? 'فشل تسجيل الدخول';
        emit(LoginFailure(serverMsg));
      }
    } on DioException catch (e) {
      // مهلات / انقطاع نت / رسائل السيرفر
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(const LoginFailure('انتهت مهلة الاتصال. تحقق من الشبكة.'));
        return;
      }
      if (e.error is SocketException) {
        emit(const LoginFailure('لا يوجد اتصال بالإنترنت.'));
        return;
      }
      final msg = _extractMessage(e.response?.data) ?? 'خطأ في الاتصال';
      emit(LoginFailure(msg));
    } catch (e) {
      emit(const LoginFailure('حدث خطأ غير متوقع'));
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map) {
      final m = data['message'] ?? data['error'] ?? data['msg'];
      return m?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }
}
