import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../linkapi.dart';
import '../../models/OrdersHistoryItem.dart';
import 'orders_history_state.dart';

class OrdersHistoryCubit extends Cubit<OrdersHistoryState> {
  final Dio dio;


  OrdersHistoryCubit({required this.dio,})
      : super(OrdersHistoryInitial());

  Future<void> loadOrdersHistory() async {
    emit(OrdersHistoryLoading());
    final prefs = await SharedPreferences.getInstance();
    String token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
    try {

      final response = await dio.post(
        '${AppLink.server}/ordersHistory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      print("📦 Response realUri: ${response.realUri}");
      print("📥 Response status: ${response.statusCode}");
      print("📦 Response data: ${response.data}");


      if (response.statusCode == 200) {
        final data = response.data['orders'] as List;
        final orders = data.map((item) => OrdersHistoryItem.fromJson(item)).toList();
        emit(OrdersHistoryLoaded(orders));
      } else {
        emit(OrdersHistoryError('Server error: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      if (e.response != null) {
        print("📥 Response error: ${e.response?.data}");
      }
      emit(OrdersHistoryError('Network error: ${e.message}'));
    } catch (e) {
      print("⚠️ Unexpected error: $e");
      emit(OrdersHistoryError('Unexpected error'));
    }
  }
}
