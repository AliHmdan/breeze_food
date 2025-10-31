import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/store_details/store_detalis_state.dart';

import '../../data/repositories/store_repository.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository repo;

  StoreCubit(this.repo) : super(StoreInitial());

  Future<void> loadStoreDetails(int restaurantId) async {
    emit(StoreLoading());

    try {
      final data = await repo.fetchStoreDetails(
        restaurantId: restaurantId,
      );
      emit(StoreLoaded(data));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }
}
