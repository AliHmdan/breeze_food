

import 'package:flutter/material.dart';
import 'package:freeza_food/models/user_model.dart';


@immutable
abstract class VerifyCodeState {}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final String token;
  final UserModel user;
  VerifyCodeSuccess(this.token, this.user);
}

class VerifyCodeFailure extends VerifyCodeState {
  final String message;
  VerifyCodeFailure(this.message);
}

class ResendCodeLoading extends VerifyCodeState {}

class ResendCodeSuccess extends VerifyCodeState {}
