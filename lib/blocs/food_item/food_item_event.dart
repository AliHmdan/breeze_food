import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFoodEvent extends FoodEvent {}
