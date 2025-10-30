// Models for the Home / Main Interface response
// Hand-rolled models with fromJson to match existing project style

class HomeResponseModel {
  final List<AdModel> ads;
  final List<RestaurantModel> nearbyRestaurants;
  final List<MenuItemModel> mostPopular;
  final List<DiscountModel> discounts;
  final List<StoryItem> stories;
  final bool hasCoordinates;
  final bool hasOrder;
  final String? provinceDetected;

  HomeResponseModel({
    required this.ads,
    required this.nearbyRestaurants,
    required this.mostPopular,
    required this.discounts,
    required this.stories,
    required this.hasCoordinates,
    required this.hasOrder,
    this.provinceDetected,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    final adsJson = json['ads'] as List<dynamic>? ?? [];
    final nearbyJson = json['nearby_restaurants'] as List<dynamic>? ?? [];
    final popularJson = json['most_popular'] as List<dynamic>? ?? [];
    final discountsJson = json['discounts'] as List<dynamic>? ?? [];
    // discounts from backend can be either a list of coupon objects or a list
    // of wrapper objects that contain a `data` array (legacy). We normalize
    // by flattening any `data` arrays and then attempting to parse each item.
    final List<dynamic> flattenedDiscounts = [];
    for (final d in discountsJson) {
      if (d is Map<String, dynamic> && d['data'] is List) {
        flattenedDiscounts.addAll(d['data'] as List<dynamic>);
      } else {
        flattenedDiscounts.add(d);
      }
    }

    // Try to parse discounts; be tolerant if shape differs and skip items that fail parsing
    final List<DiscountModel> parsedDiscounts = [];
    for (final item in flattenedDiscounts) {
      try {
        if (item is Map<String, dynamic>) {
          parsedDiscounts.add(DiscountModel.fromJson(item));
        }
      } catch (e) {
        // ignore single-item parse failures but log for debugging
        // ignore: avoid_print
        print(
          'HomeResponseModel.fromJson -> failed to parse discount item: $e',
        );
      }
    }

    // Stories: backend returns wrappers with `story_data` inside each item
    final storiesJson = json['stories'] as List<dynamic>? ?? [];
    final stories = storiesJson
        .map<StoryItem?>((e) {
          try {
            final sd =
                (e as Map<String, dynamic>)['story_data']
                    as Map<String, dynamic>;
            return StoryItem.fromJson(sd);
          } catch (err) {
            // ignore parse failure for a single story
            // ignore: avoid_print
            print('HomeResponseModel.fromJson -> failed parse story: $err');
            return null;
          }
        })
        .whereType<StoryItem>()
        .toList();

    return HomeResponseModel(
      ads: adsJson.map((e) => AdModel.fromJson(e)).toList(),
      nearbyRestaurants: nearbyJson
          .map((e) => RestaurantModel.fromJson(e))
          .toList(),
      mostPopular: popularJson.map((e) => MenuItemModel.fromJson(e)).toList(),
      discounts: parsedDiscounts,
      stories: stories,
      hasCoordinates: json['has_coordinates'] == true,
      hasOrder: json['have_order'] != null,
      provinceDetected: json['province_detected'] as String?,
    );
  }
}

class StoryItem {
  final int id;
  final int restaurantId;
  final String title;
  final String description;
  final String image; // relative or absolute
  final String restaurantName;

  StoryItem({
    required this.id,
    required this.restaurantId,
    required this.title,
    required this.description,
    required this.image,
    required this.restaurantName,
  });

  factory StoryItem.fromJson(Map<String, dynamic> j) {
    return StoryItem(
      id: j['id'] as int,
      restaurantId: j['restaurant_id'] as int? ?? 0,
      title: j['title'] as String? ?? '',
      description: j['description'] as String? ?? '',
      image: j['image'] as String? ?? '',
      restaurantName:
          (j['restaurant'] as Map<String, dynamic>?)?['name'] as String? ?? '',
    );
  }
}

class AdModel {
  final int id;
  final String type;
  final String title;
  final String description;
  final String image; // may be relative path
  final String? url;

  AdModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.image,
    this.url,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
    id: json['id'] as int,
    type: json['type'] as String? ?? 'image',
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    image: json['image'] as String? ?? '',
    url: json['url'] as String?,
  );
}

class RestaurantModel {
  final int id;
  final String name;
  final String? description;
  final String? phone;
  final String? address;
  final String? logo;
  final String? coverImage;
  final List<CategoryModel> categories;
  final List<MenuItemModel> menuItems;

  RestaurantModel({
    required this.id,
    required this.name,
    this.description,
    this.phone,
    this.address,
    this.logo,
    this.coverImage,
    this.categories = const [],
    this.menuItems = const [],
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    final categoriesJson = json['categories'] as List<dynamic>? ?? [];
    final menuItemsJson = json['menu_items'] as List<dynamic>? ?? [];
    return RestaurantModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      logo: json['logo'] as String?,
      coverImage: json['cover_image'] as String?,
      categories: categoriesJson.map((e) => CategoryModel.fromJson(e)).toList(),
      menuItems: menuItemsJson.map((e) => MenuItemModel.fromJson(e)).toList(),
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final List<TranslationModel> translations;

  CategoryModel({
    required this.id,
    required this.name,
    this.translations = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final translationsJson = json['translations'] as List<dynamic>? ?? [];
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      translations: translationsJson
          .map((e) => TranslationModel.fromJson(e))
          .toList(),
    );
  }
}

class TranslationModel {
  final int id;
  final String locale;
  final String name;

  TranslationModel({
    required this.id,
    required this.locale,
    required this.name,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
        id: json['id'] as int,
        locale: json['locale'] as String? ?? '',
        name: json['name'] as String? ?? '',
      );
}

class MenuItemModel {
  final int id;
  final int restaurantId;
  final String name;
  final String? description;
  final String basePrice;
  final bool hasVariations;
  final String?
  primaryImageUrl; // optional primary image (relative or absolute)

  MenuItemModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.description,
    required this.basePrice,
    required this.hasVariations,
    this.primaryImageUrl,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => MenuItemModel(
    id: json['id'] as int,
    restaurantId: json['restaurant_id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    description: json['description'] as String?,
    basePrice: json['base_price']?.toString() ?? '0',
    hasVariations: json['has_variations'] == true,
    primaryImageUrl: json['primary_image'] != null
        ? (json['primary_image']['image_url'] as String?)
        : null,
  );
}

class DiscountModel {
  final int couponId;
  final String code;
  final String discountType;
  final double discountValue;
  final bool isAvailableForUser;
  final CouponRestaurant? restaurant;
  final List<MenuItemSimple> menuItems;

  DiscountModel({
    required this.couponId,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.isAvailableForUser,
    this.restaurant,
    this.menuItems = const [],
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    // Support two shapes:
    // 1) Coupon-style: { coupon_id, code, discount_type, discount_value, restaurant, menu_items }
    // 2) Home-discount-style from /home endpoint: { id, name_ar, name_en, price, image, restaurant_name, restaurant_logo, discount_type, discount_value, is_favorite }

    // Detect coupon-style
    if (json.containsKey('coupon_id')) {
      final menuItemsJson = json['menu_items'] as List<dynamic>? ?? [];
      return DiscountModel(
        couponId: json['coupon_id'] as int,
        code: json['code'] as String? ?? '',
        discountType: json['discount_type'] as String? ?? '',
        discountValue: (json['discount_value'] is num)
            ? (json['discount_value'] as num).toDouble()
            : double.tryParse(json['discount_value']?.toString() ?? '0') ?? 0,
        isAvailableForUser: json['is_available_for_user'] == true,
        restaurant: json['restaurant'] != null
            ? CouponRestaurant.fromJson(json['restaurant'])
            : null,
        menuItems: menuItemsJson
            .map((e) => MenuItemSimple.fromJson(e))
            .toList(),
      );
    }

    // Otherwise treat as home-discount item
    // Create a DiscountModel with best-effort mapping
    try {
      final id = json['id'] as int? ?? 0;
      final nameEn =
          json['name_en'] as String? ?? json['name_ar'] as String? ?? '';
      final price = (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0') ?? 0;
      final dtype = json['discount_type'] as String? ?? '';
      final dvalue = (json['discount_value'] is num)
          ? (json['discount_value'] as num).toDouble()
          : double.tryParse(json['discount_value']?.toString() ?? '0') ?? 0;
      final restaurantName = json['restaurant_name'] as String? ?? '';

      // We will fill couponId with id and code with nameEn to keep some fields usable
      return DiscountModel(
        couponId: id,
        code: nameEn,
        discountType: dtype,
        discountValue: dvalue,
        isAvailableForUser: json['is_favorite'] == true,
        restaurant: CouponRestaurant(id: 0, name: restaurantName),
        menuItems: [
          MenuItemSimple(
            id: id,
            nameAr: json['name_ar'] as String? ?? '',
            nameEn: nameEn,
          ),
        ],
      );
    } catch (e) {
      // Last resort: throw so caller can catch and skip
      rethrow;
    }
  }
}

class CouponRestaurant {
  final int id;
  final String name;

  CouponRestaurant({required this.id, required this.name});

  factory CouponRestaurant.fromJson(Map<String, dynamic> json) =>
      CouponRestaurant(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
      );
}

class MenuItemSimple {
  final int id;
  final String nameAr;
  final String nameEn;

  MenuItemSimple({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory MenuItemSimple.fromJson(Map<String, dynamic> json) => MenuItemSimple(
    id: json['id'] as int,
    nameAr: json['name_ar'] as String? ?? '',
    nameEn: json['name_en'] as String? ?? '',
  );
}
