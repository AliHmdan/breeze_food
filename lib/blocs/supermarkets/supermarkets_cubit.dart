import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/supermarkets/supermarkets_state.dart';
import 'package:freeza_food/data/repositories/super_market_repository.dart';


class SuperMarketsCubit extends Cubit<SuperMarketsState> {
  final SuperMarketRepository repo;
  SuperMarketsCubit({required this.repo}) : super(SuperMarketsInitial());

  Future<void> loadMarkets() async {
    emit(SuperMarketsLoading());
    try {
      final list = await repo.fetchAllMarkets();
      emit(SuperMarketsLoaded(list));
    } catch (e) {
      emit(SuperMarketsError(e.toString()));
    }
  }
}
