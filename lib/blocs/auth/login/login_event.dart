
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String phone;
  final String password;

  LoginSubmitted(this.phone, this.password);

  @override
  List<Object?> get props => [phone, password];
}
