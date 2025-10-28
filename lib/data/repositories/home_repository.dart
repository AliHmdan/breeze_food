import 'package:dio/dio.dart';
import 'package:freeza_food/linkapi.dart';
import 'package:freeza_food/data/model/home_model.dart';

class HomeRepository {
  final Dio _dio = Dio();

  /// Fetch main interface data.
  /// Returns [HomeResponseModel] on success, throws on error.
  Future<HomeResponseModel> getHome(String token) async {
    try {
      final response = await _dio.get(
        AppLink.home,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return HomeResponseModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch home data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Map DioException to a readable error
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('Network error fetching home data: $msg');
    } catch (e) {
      throw Exception('Unexpected error fetching home data: $e');
    }
  }
}
