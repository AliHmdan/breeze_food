import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/data/repositories/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;
  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = "28|BryfypIXROJ7QU5fq4OCZtXuqd6F9RCqGdEtWVVG293965fa";

      if (token == null) {
        emit(HomeFailure("No authentication token found"));
        return;
      }

      final data = await repository.getHome(token);
      emit(HomeLoaded(data));
    } catch (e) {
      // keep the error message friendly
      emit(HomeFailure(e.toString()));
    }
  }
}
