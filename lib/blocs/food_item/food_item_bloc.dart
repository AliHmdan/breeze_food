import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/FoodItem.dart';
import 'food_item_event.dart';
import 'food_item_state.dart';


class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<LoadFoodEvent>((event, emit) async {
      emit(FoodLoading());

      // بيانات تجريبية (ستستبدل لاحقاً ببيانات API)
      await Future.delayed(Duration(seconds: 1)); // محاكاة انتظار API
      List<FoodModel> dummyFoods = [
        FoodModel(
          restaurant: "Chicken House",
          time: "15-40 min",
          rating: 4.9,
          orders: "500+ Order",
          title: "Chicken shish",
          subtitle: "burger king",
          price: "2.00\$",
          image: "https://i.ibb.co/PMdcm0g/food.jpg",
        ),
        FoodModel(
          restaurant: "Chicken House",
          time: "15-40 min",
          rating: 4.9,
          orders: "500+ Order",
          title: "Chicken shish",
          subtitle: "burger king",
          price: "2.00\$",
          image: "https://i.ibb.co/PMdcm0g/food.jpg",
        ),
      ];

      emit(FoodLoaded(dummyFoods));
    });
  }
}
