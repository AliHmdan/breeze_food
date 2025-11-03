import '../../data/model/restaurant_details_model.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final RestaurantDetailsModel data;
  StoreLoaded(this.data);
}

class StoreError extends StoreState {
  final String message;
  StoreError(this.message);
}
