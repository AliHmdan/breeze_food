import 'package:breezefood/linkapi.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        AppLink.login, // رابط API
        data: {
          "phone": phone, // بدل phone
          "password": password,      // كلمة المرور
        },
        options: Options(
          headers: {
            "Content-Type": "application/json", // الـ API يستقبل JSON
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
}
