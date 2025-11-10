
import 'package:dio/dio.dart';
import 'package:freeza_food/linkapi.dart';
import 'package:freeza_food/models/api_market_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuperMarketRepository {
  final Dio _dio;

  SuperMarketRepository({Dio? dio})
      : _dio = dio ??
      Dio(BaseOptions(
        baseUrl: AppLink.server,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

  Future<List<ApiMarket>> fetchAllMarkets() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ??
        "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";

    final response = await _dio.get(
      "${AppLink.server}/super-markets/all",
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data == null || data['markets'] == null) return [];
      final list = data['markets'] as List;
      return list.map((e) => ApiMarket.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load markets: ${response.statusCode}');
    }
  }
}
