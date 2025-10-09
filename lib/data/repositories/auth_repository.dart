import 'package:freeza_food/linkapi.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        AppLink.login, // رابط API
        data: {
          "identifier": phone, // بدل phone
          "password": password,      // كلمة المرور
        },
        options: Options(
          headers: {
            "Content-Type": "application/json", // الـ API يستقبل JSON
          },
        ),
      );
      print(response.data);
      print(response.statusCode);
      print(response.realUri);

      return response.data;
    } catch (e, stackTrace) {
      throw Exception("Login failed: $e $stackTrace");
    }
  }

  Future<Response> register({
    required String phone,
    required String password,
    required String confirmPassword,
    String? referralCode,
  }) async {
    final data = {
      "phone": phone,
      "password": password,
      "password_confirmation": confirmPassword,
      "referral_code": referralCode ?? "",
    };

    return await _dio.post(AppLink.signup, data: data);
  }

  Future<Response> verifyPhone({
    required String phone,
    required String code,
  }) async {
    final data = {
      "phone": phone,
      "code": code,
    };

    return await _dio.post(AppLink.verifyPhone, data: data);
  }

  Future<Response> resendCode({
    required String phone,
  }) async {
    return await _dio.post(AppLink.resendCode, data: {
      "phone": phone,
    });
  }
  Future<Response> logout({required String token}) async {
    return await _dio.post(
      AppLink.logout,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

}
