import 'package:equatable/equatable.dart';

/// 🔵 الأحداث (الطلبات) التي ممكن تحصل في الـ AuthBloc
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// 📌 تسجيل مستخدم جديد
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });
}

/// 📌 تأكيد رقم الهاتف
class VerifyPhoneEvent extends AuthEvent {
  final String phone;
  final String code;

  const VerifyPhoneEvent({
    required this.phone,
    required this.code,
  });
}

/// 📌 إعادة إرسال رمز التفعيل
class ResendCodeEvent extends AuthEvent {
  final String phone;

  const ResendCodeEvent({required this.phone});
}

/// 📌 تسجيل الدخول
class LoginEvent extends AuthEvent {
  final String identifier; // رقم هاتف أو إيميل
  final String password;

  const LoginEvent({
    required this.identifier,
    required this.password,
  });
}
