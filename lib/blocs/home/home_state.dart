import 'package:freeza_food/data/model/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeResponseModel data;
  HomeLoaded(this.data);
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}
