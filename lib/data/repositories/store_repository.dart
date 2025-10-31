import 'package:dio/dio.dart';

import '../../linkapi.dart';
import '../model/restaurant_details_model.dart';

class StoreRepository {
  final Dio dio;

  StoreRepository({Dio? dio})
      : dio = dio ??
      Dio(BaseOptions(
        baseUrl: AppLink.server,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

  Future<RestaurantDetailsModel> fetchStoreDetails({
    required int restaurantId,
  }) async {
    String token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
    try {
      final response = await dio.post(
        AppLink.restaurantDetails,
        data: { "restaurant_id": restaurantId },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      return RestaurantDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
