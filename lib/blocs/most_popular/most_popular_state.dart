import '../../data/model/popular_item_model.dart';

abstract class PopularState {}

class PopularInitial extends PopularState {}
class PopularLoading extends PopularState {}
class PopularLoaded extends PopularState {
  final List<PopularItemModel> items;
  PopularLoaded(this.items);
}
class PopularError extends PopularState {
  final String message;
  PopularError(this.message);
}
