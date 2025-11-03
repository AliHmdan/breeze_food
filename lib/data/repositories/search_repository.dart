import 'dart:convert';
import 'package:freeza_food/data/model/search/search_history_model.dart';
import 'package:freeza_food/data/model/search/search_result_model.dart';
import 'package:freeza_food/linkapi.dart';
import 'package:dio/dio.dart';

class SearchRepository {
  final Dio _dio;

  SearchRepository({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              // لو عندك baseUrl في AppLink خليه هنا، وإلا اتركه فاضي
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 30),
              // نرجّع الاستجابة حتى لو 4xx/5xx علشان نقرأ رسالة الخطأ
              validateStatus: (status) => status != null && status >= 200 && status < 600,
              responseType: ResponseType.json,
              contentType: Headers.jsonContentType, // application/json; charset=utf-8
            ));

  Map<String, String> _headers(String token) => {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
      };

  // -------------------- History --------------------
  Future<List<SearchHistoryModel>> getSearchHistory(String token) async {
    try {
      final response = await _dio.get(
        AppLink.searchHistory,
        options: Options(headers: _headers(token)),
      );

      _debugResponse("GET ${response.realUri}", response);

      if (response.statusCode == 200) {
        final data = response.data;
        // بعض الـ APIs ممكن ترجع { success, history: [...] }
        final List<dynamic> historyData =
            (data is Map && data['history'] is List) ? data['history'] : (data as List? ?? []);
        return historyData.map((e) => SearchHistoryModel.fromJson(e)).toList();
      }

      throw _wrapHttpError(response, fallback: "Failed to fetch search history");
    } catch (e, st) {
      throw Exception("Error fetching search history: ${_msg(e)}\n$st");
    }
  }

  // -------------------- Search --------------------
  Future<SearchResultModel> performSearch(String token, String query) async {
    try {
      final payload = {
        "query": query,
      };

      // تأكد أن البودي UTF-8 (Dio يعملها تلقائيًا، السطر التالي احترازي)
      final body = jsonEncode(payload);

      final response = await _dio.post(
        AppLink.search,
        data: body,
        options: Options(headers: _headers(token)),
      );

      _debugResponse("POST ${response.realUri}", response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // أحيانًا الـ API يرجع success:false حتى مع 200
        if (response.data is Map && response.data['success'] == false) {
          final msg = response.data['message']?.toString() ?? "Search failed";
          throw Exception(msg);
        }
        return SearchResultModel.fromJson(response.data);
      }

      throw _wrapHttpError(response, fallback: "Failed to perform search");
    } catch (e, st) {
      throw Exception("Error performing search: ${_msg(e)}\n$st");
    }
  }

  // -------------------- Helpers --------------------
  Exception _wrapHttpError(Response res, {required String fallback}) {
    try {
      final data = res.data;
      String serverMsg = "";

      if (data is Map) {
        serverMsg = (data['message'] ?? data['error'] ?? "").toString();
      } else if (data is String && data.isNotEmpty) {
        serverMsg = data;
      }

      final reason = serverMsg.isNotEmpty ? serverMsg : res.statusMessage ?? fallback;
      return Exception("$fallback (HTTP ${res.statusCode}): $reason");
    } catch (_) {
      return Exception("$fallback (HTTP ${res.statusCode})");
    }
  }

  void _debugResponse(String label, Response res) {
    // سجّل عنوان الطلب، الكود، وقص جزء من البودي (مفيد جدًا أثناء التطوير)
    // يمكنك استبدال print بأي لوجر تستخدمه
    print("[$label] => ${res.statusCode}");
    print("Headers: ${res.headers.map}");
    try {
      print("Body: ${res.data}");
    } catch (_) {}
  }

  String _msg(Object e) {
    if (e is DioException) {
      return e.response?.data?.toString() ?? e.message ?? e.toString();
    }
    return e.toString();
  }
}
