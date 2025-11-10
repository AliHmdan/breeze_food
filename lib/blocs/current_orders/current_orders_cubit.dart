import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../linkapi.dart';
import '../../models/current_orders_model.dart';
import 'current_orders_state.dart';

class CurrentOrdersCubit extends Cubit<CurrentOrdersState> {
  final Dio dio;


  CurrentOrdersCubit({required this.dio,})
      : super(CurrentOrdersInitial());

  Future<void> loadCurrentOrders(String token) async {
    emit(CurrentOrdersLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      String token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
      final response = await dio.post(
        '${AppLink.server}/activeOrders',
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
        final orders =
        data.map((item) => CurrentOrderItem.fromJson(item)).toList();
        emit(CurrentOrdersLoaded(orders));
      } else {
        emit(CurrentOrdersError('Server error: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      if (e.response != null) {
        print("📥 Response error: ${e.response?.data}");
      }
      emit(CurrentOrdersError('Network error: ${e.message}'));
    } catch (e) {
      print("⚠️ Unexpected error: $e");
      emit(CurrentOrdersError('Unexpected error'));
    }
  }
}
