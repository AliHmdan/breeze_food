import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/screens/add_order/add_order.dart';
import 'package:freeza_food/presentation/widgets/store_details/horizontal_products_section.dart';
import 'package:freeza_food/presentation/widgets/store_details/pinch_zoom_header.dart';
import 'package:freeza_food/presentation/widgets/store_details/shadows.dart';
import 'package:freeza_food/presentation/widgets/store_details/v_divider.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:freeza_food/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/store_details/store_detalis_cubit.dart';
import '../../../blocs/store_details/store_detalis_state.dart';
import '../../../core/constans/color.dart';
import '../../../data/model/restaurant_details_model.dart';
import '../../../data/repositories/store_repository.dart';
import '../../widgets/home/custom_title_section.dart';
import '../../widgets/home/most_popular.dart';
import '../../widgets/tiem_price.dart';

class StoreDetailsBloc extends StatefulWidget {
  final int restaurantId;
  final List<String> categories;
  const StoreDetailsBloc({super.key,
    required this.restaurantId,
    required this.categories,

  });

  @override
  State<StoreDetailsBloc> createState() => _StoreDetailsBlocState();
}

class _StoreDetailsBlocState extends State<StoreDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreCubit(StoreRepository())
        ..loadStoreDetails(widget.restaurantId),
  child: StoreDetails( categories: ["fhdf","dhsghjdg"],),
);
  }
}


class StoreDetails extends StatefulWidget {

  final List<String> categories;

  const StoreDetails({
    super.key,
    required this.categories,
  });

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}


class _StoreDetailsState extends State<StoreDetails> {
  final ScrollController _scrollController = ScrollController();
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<StoreCubit>().loadStoreDetails( widget.restaurantId);
  // }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state is StoreLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is StoreError) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
            }

            if (state is StoreLoaded) {
              final data = state.data;

              final general = data.general;
              final orders = data.myOrders;
              final favorites = data.myFavorites;
              final menuItems = data.menuItems;

              return SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// ✅ Header image
                    PinchZoomHeader(
                      imagePath: general.cover,
                      height: 200.h,
                      maxScale: 1.25,
                    ),

                    Transform.translate(
                      offset: Offset(0, -16.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.Dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22.r),
                            topRight: Radius.circular(22.r),
                          ),
                          boxShadow: const [kLiftedEdgeShadow],
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ✅ Time + Delivery Fee
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TiemPrice(
                                    svgPath: "assets/icons/time.svg",
                                    title: "${general.deliveryTime}",
                                    subtitle: "min",
                                  ),
                                  TiemPrice(
                                    title: general.deliveryCash.toString(),
                                    subtitle: "\$",
                                    svgPath: "assets/icons/motor.svg",
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),

                              /// ✅ Restaurant name
                              Row(
                                children: [
                                  Spacer(),
                                  CustomTitle(
                                    title: general.name,
                                    color: AppColor.white,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoute.search);
                                    },
                                    icon: Icon(Icons.search, color: AppColor.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),

                              /// ✅ Description + rating + total orders
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomSubTitle(
                                      subtitle: general.description,
                                      color: AppColor.gry,
                                      fontsize: 10.sp,
                                    ),
                                  ),
                                  const VDividerThin(),
                                  Icon(Icons.star, color: AppColor.yellow, size: 16.sp),
                                  SizedBox(width: 2.w),
                                  Text(general.avgRating.toString(),
                                      style: TextStyle(color: AppColor.white, fontSize: 11.sp)),
                                  const VDividerThin(),
                                  Text("${general.totalOrders}+ Orders",
                                      style: TextStyle(color: AppColor.white, fontSize: 11.sp)),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              /// ✅ Categories
                              _buildCategories(),

                              SizedBox(height: 16.h),

                              /// ✅ Order Again
                              CustomTitleSection(title: "Order again"),
                              SizedBox(height: 10.h),
                              _buildHorizontalProducts(orders),

                              SizedBox(height: 16.h),

                              /// ✅ Customer Favorite
                              CustomTitleSection(title: "Customer Favorite"),
                              SizedBox(height: 10.h),
                              _buildHorizontalProducts(favorites),

                              SizedBox(height: 16.h),

                              /// ✅ Menu items
                              CustomTitleSection(title: "Shawarma"),
                              SizedBox(height: 10.h),
                              _buildHorizontalProducts(menuItems),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        )

      ),
    );
  }
  Widget _buildCategories() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(50.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColor.Dark,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
              child: CustomSubTitle(
                subtitle: widget.categories[index],
                color: AppColor.white,
                fontsize: 12.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalProducts(List<RestaurantItemModel> items) {
    return SizedBox(
      height: 170.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, i) {
          final item = items[i];
          return GestureDetector(
            onTap: () {
              // open meal details page using item.id
              // مثال: Navigator.pushNamed(context, AppRoute.mealDetails, arguments: item.id);
            },
            child: PopularItemCard(
              imagePath: item.image,
              title: item.name,
              price: item.price.toString(),
              oldPrice: null,
              isFavorite: item.isFavorite,
              onFavoriteToggle: () {},
            ),
          );
        },
      ),
    );
  }


}
