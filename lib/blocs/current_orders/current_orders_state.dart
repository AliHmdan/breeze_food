
import '../../models/current_orders_model.dart';

abstract class CurrentOrdersState {}

class CurrentOrdersInitial extends CurrentOrdersState {}

class CurrentOrdersLoading extends CurrentOrdersState {}

class CurrentOrdersLoaded extends CurrentOrdersState {
  final List<CurrentOrderItem> orders;
  CurrentOrdersLoaded(this.orders);
}

class CurrentOrdersError extends CurrentOrdersState {
  final String message;
  CurrentOrdersError(this.message);
}
