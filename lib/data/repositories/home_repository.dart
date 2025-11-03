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
            // use the token passed into the method (do not hardcode)
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print(response.data);
      print("Home response status: ${response.statusCode}");
      // DEBUG: print status and body to help diagnose failures
      // (will print to console / debug output)
      // Note: response.data may be Map or List depending on backend; we try to cast when appropriate.
      // Print raw response for debugging
      // ignore: avoid_print
      print('HomeRepository.getHome -> status: ${response.statusCode}');
      // ignore: avoid_print
      print('HomeRepository.getHome -> data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return HomeResponseModel.fromJson(data);
      } else {
        // include response body in the thrown exception for visibility
        final body = response.data;
        throw Exception(
          'Failed to fetch home data: ${response.statusCode} - $body',
        );
      }
    } on DioException catch (e) {
      // Map DioException to a readable error and print details to console
      // ignore: avoid_print
      print(
        'HomeRepository.getHome -> DioException: status=${e.response?.statusCode} data=${e.response?.data} message=${e.message}',
      );
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('Network error fetching home data: $msg');
    } catch (e) {
      // ignore: avoid_print
      print('HomeRepository.getHome -> Unexpected error: $e');
      throw Exception('Unexpected error fetching home data: $e');
    }
  }
}
