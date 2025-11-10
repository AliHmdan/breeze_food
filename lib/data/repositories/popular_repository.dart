import 'package:dio/dio.dart';
import '../../linkapi.dart';
import '../model/popular_item_model.dart';

class PopularRepository {
  final Dio dio;

  PopularRepository({Dio? dio})
      : dio = dio ??
      Dio(BaseOptions(
        baseUrl: AppLink.server,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

  Future<List<PopularItemModel>> fetchPopularItems() async {
    String token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
    try {
      final response = await dio.get(
        AppLink.mostPopular,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final menuItems = response.data["menu_items"] as List<dynamic>?;

        if (menuItems == null || menuItems.isEmpty) return [];

        return menuItems
            .map((e) => PopularItemModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load popular items: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
