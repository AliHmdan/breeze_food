part of 'discount_cubit.dart';

abstract class DiscountState {}

class DiscountInitial extends DiscountState {}

class DiscountLoading extends DiscountState {}

class DiscountLoaded extends DiscountState {
  final List<DiscountModel> list;
  DiscountLoaded(this.list);
}

class DiscountError extends DiscountState {
  final String message;
  DiscountError(this.message);
}
