import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/popular_repository.dart';
import 'most_popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  final PopularRepository repository;
  PopularCubit(this.repository) : super(PopularInitial());

  Future<void> loadPopularItems() async {

    emit(PopularLoading());
    try {
      final items = await repository.fetchPopularItems();
      emit(PopularLoaded(items));
    } catch (e) {
      emit(PopularError(e.toString()));
    }
  }
}
