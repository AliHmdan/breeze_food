

import 'package:flutter/material.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final dynamic data;
  SignupSuccess(this.data);
}

class SignupFailure extends SignupState {
  final String message;
  SignupFailure(this.message);
}
