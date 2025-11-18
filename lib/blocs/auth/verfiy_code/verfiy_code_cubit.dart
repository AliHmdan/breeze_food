

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/auth/verfiy_code/verfiy_code_state.dart';
import 'package:freeza_food/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/auth_repository.dart';


class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  final AuthRepository authRepository;
  VerifyCodeCubit(this.authRepository) : super(VerifyCodeInitial());

  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    emit(VerifyCodeLoading());
    try {
      final response = await authRepository.verifyPhone(phone: phone, code: code);
      if (response.statusCode == 200) {
        final token = response.data["token"];
        final user = UserModel.fromJson(response.data["user"]);
print("profile !!!! ${user.toJson().toString()}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setString("user", user.toJson().toString());

        emit(VerifyCodeSuccess(token, user));
      } else {
        emit(VerifyCodeFailure("رمز غير صالح"));
      }
    } on DioException catch (e) {
      emit(VerifyCodeFailure(e.response?.data["message"] ?? "فشل الاتصال"));
    } catch (_) {
      emit(VerifyCodeFailure("خطأ غير متوقع"));
    }
  }

  Future<void> resendCode(String phone) async {
    emit(ResendCodeLoading());
    try {
      final response = await authRepository.resendCode(phone: phone);
      if (response.statusCode == 200) {
        emit(ResendCodeSuccess());
      } else {
        emit(VerifyCodeFailure("فشل في إعادة الإرسال"));
      }
    } on DioException catch (e) {
      print(e.response?.statusCode);
      emit(VerifyCodeFailure(e.response?.data["message"] ?? "خطأ في الاتصال"));
    } catch (_) {
      emit(VerifyCodeFailure("حدث خطأ"));
    }
  }
}

