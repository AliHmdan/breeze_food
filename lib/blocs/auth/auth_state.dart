import 'package:equatable/equatable.dart';

/// 🟡 الحالات التي تعبر عن وضع الـ Bloc
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// البداية (ما في أي عملية جارية)
class AuthInitial extends AuthState {}

/// جاري تنفيذ العملية
class AuthLoading extends AuthState {}

/// نجاح العملية (مع إمكانية إرجاع أي موديل)
class AuthSuccess<T> extends AuthState {
  final T data;
  const AuthSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

/// فشل العملية
class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
