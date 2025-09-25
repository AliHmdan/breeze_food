import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
// import import'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio dio;

  AuthBloc({required this.dio}) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<VerifyPhoneEvent>(_onVerifyPhone);
    on<ResendCodeEvent>(_onResendCode);
    on<LoginEvent>(_onLogin);
  }

  /// 📌 تسجيل مستخدم جديد
  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await dio.post(
        "api/register",
        data: {
          "name": event.name,
          "email": event.email,
          "phone": event.phone,
          "password": event.password,
          "password_confirmation": event.passwordConfirmation,
          "type": "customer",
        },
      );
      emit(AuthSuccess(RegisterResponse.fromJson(response.data)));
    } catch (e) {
      emit(AuthFailure(_handleError(e)));
    }
  }

  /// 📌 تأكيد رقم الهاتف
  Future<void> _onVerifyPhone(VerifyPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await dio.post(
        "api/verify-phone",
        data: {
          "phone": event.phone,
          "code": event.code,
        },
      );
      emit(AuthSuccess(RegisterResponse.fromJson(response.data)));
    } catch (e) {
      emit(AuthFailure(_handleError(e)));
    }
  }

  /// 📌 إعادة إرسال الكود
  Future<void> _onResendCode(ResendCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await dio.post(
        "api/resend-code",
        data: {
          "phone": event.phone,
        },
      );
      emit(AuthSuccess(RegisterResponse.fromJson(response.data)));
    } catch (e) {
      emit(AuthFailure(_handleError(e)));
    }
  }

  /// 📌 تسجيل الدخول + تخزين البيانات
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await dio.post(
        "api/login",
        data: {
          "identifier": event.identifier,
          "password": event.password,
        },
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      // 🗄️ تخزين البيانات في SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString("token", loginResponse.token);
      // await prefs.setString("user", loginResponse.user.toJson().toString());

      emit(AuthSuccess(loginResponse));
    } catch (e) {
      emit(AuthFailure(_handleError(e)));
    }
  }

  /// 🛠️ دالة مساعدة لعرض الأخطاء
  String _handleError(dynamic e) {
    if (e is DioError) {
      if (e.response != null && e.response?.data != null) {
        return e.response?.data['message'] ?? "حدث خطأ غير متوقع";
      }
      return e.message ?? "خطأ في الاتصال بالسيرفر";
    }
    return "فشل غير متوقع";
  }
}
