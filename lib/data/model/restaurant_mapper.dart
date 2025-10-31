import 'package:freeza_food/data/model/restaurant.dart' as ui;
import 'package:freeza_food/data/model/restaurant_model.dart';


extension ApiToUiRestaurant on ApiRestaurant {
  ui.Restaurant toUiModel(String imageBaseUrl) {
    final cover = coverImage.startsWith("http")
        ? coverImage
        : (imageBaseUrl.trim().endsWith("/") ? imageBaseUrl : "$imageBaseUrl/") + coverImage;

    return ui.Restaurant(
      imageUrl: cover, // cover image للـ UI
      name: name,
      rating: ratingAvg,
      orders: "${ratingCount} Rating",
      time: "${deliveryTime}M",
    );
  }
}
