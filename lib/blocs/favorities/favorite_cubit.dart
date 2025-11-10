import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../linkapi.dart';
import '../../models/favorite_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final Dio dio;


  FavoriteCubit({required this.dio,})
      : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = "49|60ugUDfVdY0DLpnhvsAKzaAbt950sEfyIUimJKWwe9dbbffb";
      final response = await dio.get(
        '${AppLink.server}/favorites',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );
print(response.realUri);
print(response.statusCode);
print(response.data);

      if (response.statusCode == 200) {
        final data = response.data['my_favorites'] as List;
        final favorites =
        data.map((item) => FavoriteItem.fromJson(item)).toList();
        emit(FavoriteLoaded(favorites));
      } else {
        emit(FavoriteError('Server error: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      final message = e.response != null
          ? 'Network error: ${e.response?.statusCode}'
          : 'Connection failed';
      emit(FavoriteError(message));
    } catch (_) {
      emit(FavoriteError('Unexpected error'));
    }
  }
}
