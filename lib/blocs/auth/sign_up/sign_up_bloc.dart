import 'dart:io';
import 'package:breezefood/blocs/auth/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      final Response response = await authRepository.register(
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        referralCode: referralCode,
      );

      // لو بدك تشوف الديبغ:
      // debugPrint('URI: ${response.requestOptions.uri}');
      // debugPrint('Status: ${response.statusCode}');
      // debugPrint('Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSuccess(response.data));
      } else {
        final data = response.data;
        final msg = (data is Map)
            ? (data['message']?.toString() ?? 'فشل التسجيل')
            : 'فشل التسجيل';
        emit(SignupFailure(msg));
      }
    } on DioException catch (e, stackTrace) {
      // debugPrint(stackTrace.toString());

      // سيناريوهات شائعة:
      // - Timeout
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(SignupFailure("انتهت مهلة الاتصال. تحقق من الشبكة وحاول مجددًا."));
        return;
      }

      // - لا يوجد إنترنت
      if (e.error is SocketException) {
        emit(SignupFailure("لا يوجد اتصال بالإنترنت."));
        return;
      }

      // - رد من السيرفر مع رسالة خطأ
      final serverMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? e.response?.data['error'])
          : null;

      emit(SignupFailure(serverMessage?.toString() ?? "خطأ في الاتصال"));
    } catch (e, stackTrace) {
      // debugPrint(stackTrace.toString());
      emit(SignupFailure("حدث خطأ غير متوقع"));
    }
  }
}
