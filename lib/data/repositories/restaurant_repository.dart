import 'package:dio/dio.dart';

import '../../linkapi.dart';
import '../model/home_model.dart';


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/restaurant_model.dart';


class RestaurantRepository {
  final Dio _dio;

  RestaurantRepository({Dio? dio})
      : _dio = dio ??
      Dio(BaseOptions(
        baseUrl: AppLink.Restaurants,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

  Future<List<ApiRestaurant>> fetchAllRestaurants() async {
    print("%%%%%%%%%%%%");
    final prefs = await SharedPreferences.getInstance();
    final token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
    if (token == null || token.isEmpty) {
      throw Exception("No auth token found in SharedPreferences");
    }
    print("%%%%%%%%%%%%${AppLink.Restaurants}");
    final response = await _dio.get(
      AppLink.Restaurants,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
print("Response status code: ${response.statusCode}");
print("Response status code: ${response.realUri}");

    if (response.statusCode == 200) {
      final data = response.data;
      if (data == null || data['restaurants'] == null) return [];
      final list = data['restaurants'] as List;
      return list.map((e) => ApiRestaurant.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      throw Exception('Failed to load restaurants: ${response.statusCode}');
    }
  }
}

