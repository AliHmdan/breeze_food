import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/auth/sign_up/sign_up_state.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../../data/repositories/auth_repository.dart';


class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit(this.authRepository) : super(SignupInitial());

  Future<void> signup({
    required String phone,
    required String password,
    required String confirmPassword,
    String? referralCode,
  }) async {
    emit(SignupLoading());
    try {
      final response = await authRepository.register(
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        referralCode: referralCode,
      );
print(response.data);
print(response.realUri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSuccess(response.data));
      } else {

        emit(SignupFailure("فشل التسجيل، تحقق من البيانات"));
      }
    } on DioException catch (e, stackTrace) {
      print(stackTrace);
      emit(SignupFailure(e.response?.data["message"] ?? "خطأ في الاتصال"));
    } catch (e,stackTrace) {
      print(stackTrace);
      emit(SignupFailure("حدث خطأ غير متوقع"));
    }
  }
}
