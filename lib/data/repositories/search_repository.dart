import 'package:freeza_food/linkapi.dart';
import 'package:freeza_food/models/search_history_model.dart';
import 'package:freeza_food/models/search_result_model.dart';
import 'package:dio/dio.dart';

class SearchRepository {
  final Dio _dio = Dio();

  Future<List<SearchHistoryModel>> getSearchHistory(String token) async {
    try {
      final response = await _dio.get(
        AppLink.searchHistory,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print(response.realUri);
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        final List<dynamic> historyData = response.data['history'] ?? [];
        return historyData
            .map((item) => SearchHistoryModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to fetch search history");
      }
    } catch (e,stackTrace) {
      throw Exception("Error fetching search history: $e $stackTrace");
    }
  }

  Future<SearchResultModel> performSearch(String token, String query) async {
    try {
      final response = await _dio.post(
        AppLink.search,
        data: {
          "query": query,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print(response.realUri);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return SearchResultModel.fromJson(response.data);
      } else {
        throw Exception("Failed to perform search");
      }
    } catch (e,stackTrace) {
      throw Exception("Error performing search: $e $stackTrace");
    }
  }
}
