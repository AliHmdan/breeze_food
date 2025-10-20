import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String phone;     // ما تدخله من الحقل (بدون +963)
  final String password;

  const LoginSubmitted(this.phone, this.password);

  @override
  List<Object?> get props => [phone, password];
}
