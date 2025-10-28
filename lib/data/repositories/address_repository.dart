import 'package:dio/dio.dart';
import 'package:freeza_food/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepository {
  final Dio _dio = Dio();

  /// Update user address with latitude and longitude.
  /// Returns the server message on success.
  Future<String> updateAddress({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = "28|BryfypIXROJ7QU5fq4OCZtXuqd6F9RCqGdEtWVVG293965fa";

      final response = await _dio.post(
        AppLink.updateAddress,
        data: {'latitude': latitude, 'longitude': longitude},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          },
        ),
      );
      print(" ${response.realUri} Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        // expected: { "data": "updated successfully" }
        if (data is Map && data['data'] != null) {
          return data['data'].toString();
        }
        return response.data.toString();
      }

      throw Exception('Failed to update address: ${response.statusCode}');
    } on DioException catch (e) {
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('Network error updating address: $msg');
    } catch (e) {
      throw Exception('Unexpected error updating address: $e');
    }
  }
}
