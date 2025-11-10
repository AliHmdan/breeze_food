
import 'package:freeza_food/models/api_market_model.dart';

abstract class SuperMarketsState {}

class SuperMarketsInitial extends SuperMarketsState {}
class SuperMarketsLoading extends SuperMarketsState {}
class SuperMarketsLoaded extends SuperMarketsState {
  final List<ApiMarket> markets;
  SuperMarketsLoaded(this.markets);
}
class SuperMarketsError extends SuperMarketsState {
  final String message;
  SuperMarketsError(this.message);
}
