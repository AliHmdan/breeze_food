import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../linkapi.dart';
import '../model/discount_model.dart';


class DiscountRepository {
  final Dio dio;

  DiscountRepository({Dio? dio})
      : dio = dio ??
      Dio(BaseOptions(
        baseUrl: AppLink.server, // فقط الـbase URL العام
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

  Future<List<DiscountModel>> fetchDiscounts() async {
    final prefs = await SharedPreferences.getInstance();
   String token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
    try {
      final response = await dio.get(
        AppLink.get_discounts,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final discountsList = response.data["discounts"] as List<dynamic>?;

        if (discountsList == null || discountsList.isEmpty) return [];

        // flatten كل data داخل كل عنصر
        final List<DiscountModel> result = [];

        for (var discountGroup in discountsList) {
          final dataList = discountGroup["data"] as List<dynamic>?;

          if (dataList != null && dataList.isNotEmpty) {
            result.addAll(
              dataList.map((e) => DiscountModel.fromJson(e)).toList(),
            );
          }
        }

        return result;
      } else {
        throw Exception("Failed to load discounts: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
