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
      // DEBUG: print token presence (do not log tokens in production)
      // ignore: avoid_print
      print('HomeCubit.loadHome -> token present: ${token != null}');

      if (token == null) {
        emit(HomeFailure("No authentication token found"));
        return;
      }

      final data = await repository.getHome(token);
      // ignore: avoid_print
      print(
        'HomeCubit.loadHome -> received HomeResponseModel with ads=${data.ads.length} nearby=${data.nearbyRestaurants.length}',
      );
      emit(HomeLoaded(data));
    } catch (e) {
      // print error to console for debugging then emit failure
      // ignore: avoid_print
      print('HomeCubit.loadHome -> error: $e');
      emit(HomeFailure(e.toString()));
    }
  }
}
