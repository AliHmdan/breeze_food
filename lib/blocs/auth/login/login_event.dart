import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

/// إرسال رقم الموبايل فقط
class LoginSubmitted extends LoginEvent {
  final String phone; // ما يدخله المستخدم

  const LoginSubmitted(this.phone);

  @override
  List<Object?> get props => [phone];
}
