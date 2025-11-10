import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/restaurants/restaurants_state.dart';

import '../../data/repositories/restaurant_repository.dart';


class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository repo;

  RestaurantCubit({required this.repo}) : super(RestaurantInitial());

  Future<void> loadRestaurants() async {
    emit(RestaurantLoading());
    try {
      final list = await repo.fetchAllRestaurants();
      emit(RestaurantLoaded(list));
    } catch (e, stacktrace) {
      print('RestaurantCubit ERROR -> $e');
      emit(RestaurantError(e.toString()));
    }
  }
}
