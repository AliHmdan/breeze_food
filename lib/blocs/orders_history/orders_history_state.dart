
import '../../models/OrdersHistoryItem.dart';

abstract class OrdersHistoryState {}

class OrdersHistoryInitial extends OrdersHistoryState {}

class OrdersHistoryLoading extends OrdersHistoryState {}

class OrdersHistoryLoaded extends OrdersHistoryState {
  final List<OrdersHistoryItem> orders;
  OrdersHistoryLoaded(this.orders);
}

class OrdersHistoryError extends OrdersHistoryState {
  final String message;
  OrdersHistoryError(this.message);
}
