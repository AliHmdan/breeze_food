import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}
class LoginOtpSent extends LoginState {
  final String phone;
  const LoginOtpSent(this.phone);
}

/// نجاح العملية (مثلاً: وصول توكن أو وصول كود OTP أو بيانات المستخدم)
class LoginSuccess extends LoginState {
  final Map<String, dynamic> data;
  const LoginSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
