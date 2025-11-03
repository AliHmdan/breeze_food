import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/discount_model.dart';
import '../../data/repositories/discount_repository.dart';

part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  final DiscountRepository repository;

  DiscountCubit(this.repository) : super(DiscountInitial());

  Future<void> loadDiscounts() async {
    emit(DiscountLoading());
    try {
      final data = await repository.fetchDiscounts();
      emit(DiscountLoaded(data));
    } catch (e,stackTrack) {

      print("Error loading discounts: $e $stackTrack");
      emit(DiscountError(e.toString()));
    }
  }
}
