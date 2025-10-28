import 'package:freeza_food/data/model/profile/user_profile.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final Dio _dio;
  ProfileRepository({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: 'https://syriansociety.org',
          headers: const {'Accept': 'application/json'},
          validateStatus: (s) => s != null && s < 500,
        ));

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<UserProfile> getMe() async {
    final r = await _dio.get('/api/me');
    if (r.statusCode == 200) return UserProfile.fromJson(r.data);
    throw Exception('Failed to load profile');
  }

  Future<UserProfile> updateProfile(UserProfile data) async {
    // لا نرسل Multipart إطلاقًا
    final r = await _dio.put('/api/me', data: data.toUpdateJson());
    if (r.statusCode == 200) return UserProfile.fromJson(r.data);
    throw Exception('Failed to update profile');
  }
}
