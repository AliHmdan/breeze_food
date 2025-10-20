import 'dart:convert';

import 'package:breezefood/blocs/auth/verfiy_code/verfiy_code_state.dart';
import 'package:breezefood/data/model/user_model.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  final AuthRepository authRepository;

  VerifyCodeCubit(this.authRepository) : super(VerifyCodeInitial());

  /// التحقق من كود التفعيل
  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    emit(VerifyCodeLoading());
    try {
      final response = await authRepository.verifyPhone(
        phone: phone,
        code: code,
      );

      // نتوقع 200 عند النجاح
      if (response.statusCode == 200) {
        final data = response.data;

        // لو الـ API يرجّع { token, user: {...} }
        final String token = data['token']?.toString() ?? '';
        if (token.isEmpty) {
          emit(VerifyCodeFailure('لم يتم استلام التوكن من الخادم.'));
          return;
        }

        // UserModel.fromJson يجب أن يطابق شكل الـ API عندك
        final userJson = data['user'];
        if (userJson == null) {
          emit(VerifyCodeFailure('بيانات المستخدم غير متوفرة.'));
          return;
        }
        final user = UserModel.fromJson(userJson);

        // حفظ آمن في SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user', jsonEncode(user.toJson()));

        emit(VerifyCodeSuccess(token, user));
      } else {
        // قراءة رسالة الخادم إن وجدت
        final msg = _extractMessage(response.data) ?? 'رمز غير صالح';
        emit(VerifyCodeFailure(msg));
      }
    } on DioException catch (e) {
      // رسائل واضحة حسب النوع
      final msg = _messageFromDio(e) ?? 'فشل الاتصال';
      emit(VerifyCodeFailure(msg));
    } catch (_) {
      emit(VerifyCodeFailure('خطأ غير متوقع'));
    }
  }

  /// إعادة إرسال كود التفعيل
  Future<void> resendCode({required String phone}) async {
    emit(ResendCodeLoading());
    try {
      final response = await authRepository.resendCode(phone: phone);

      if (response.statusCode == 200) {
        // بإمكانك قراءة response.data لو فيه message/code
        emit(ResendCodeSuccess());
      } else {
        final msg = _extractMessage(response.data) ?? 'فشل في إعادة الإرسال';
        // نستخدم VerifyCodeFailure لأن شاشة الـ UI تستمع لها
        emit(VerifyCodeFailure(msg));
      }
    } on DioException catch (e) {
      final msg = _messageFromDio(e) ?? 'خطأ في الاتصال';
      emit(VerifyCodeFailure(msg));
    } catch (_) {
      emit(VerifyCodeFailure('حدث خطأ'));
    }
  }

  // ================= Helpers =================

  String? _extractMessage(dynamic data) {
    if (data is Map) {
      final m = data['message'] ?? data['error'] ?? data['msg'];
      return m?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }

  String? _messageFromDio(DioException e) {
    // مهلات
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'انتهت مهلة الاتصال. تحقق من الشبكة وحاول مجددًا.';
    }
    // رسالة الخادم إن وجدت
    final serverData = e.response?.data;
    final serverMsg = _extractMessage(serverData);
    return serverMsg;
  }
}
