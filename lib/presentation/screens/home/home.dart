import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/Stores.dart';
import 'package:breezefood/presentation/widgets/custom_search.dart';

import 'package:breezefood/presentation/widgets/custom_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../widgets/CustomBottomNav.dart';
import '../../widgets/custom_appbar_home.dart';
import '../../widgets/custom_carousel_slider.dart';
import '../../widgets/custom_fast_food.dart';
import '../../widgets/discount.dart';
import '../../widgets/most_popular.dart';
import '../../widgets/rating_stores.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      // appBar: AppBar(backgroundColor: AppColor.Dark,
      // leading:
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbarHome(),
              const SizedBox(height: 15,),
             CustomSearch(),
              SizedBox(height: 20,),
              BrunchCarousel(),
              const SizedBox(height: 15,),
              CustomTitleSection(title: "Most popular",all: "All",icon: Icons.arrow_forward_ios_outlined,),
              const SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),

                decoration: BoxDecoration(
                  color: AppColor.black,
                    borderRadius: BorderRadius.circular(15)
                ),
                height: 230.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: PopularItemCard(
                        imagePath: 'assets/images/004.jpg',
                        title: 'Chicken shish without...',
                        subtitle: 'burger king',
                        price: '2.00\$',
                        onFavoriteToggle: () {
                          print('تم الضغط على المفضلة للعنصر رقم $index');
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10,),
              CustomTitleSection(title: "Stores",),
              Stores(),
              SizedBox(height: 2.h,),
              RatingStores(),
              const SizedBox(height: 10,),
              CustomTitleSection(title: "Discounts",all: "All",icon: Icons.arrow_forward_ios_outlined,),
              const SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),

                decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(15)
                ),
                height: 230.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Discount(
                        imagePath: 'assets/images/004.jpg',
                        title: 'Chicken shish without...',
                        subtitle: 'burger king',
                        price: '2.00\$',
                        onFavoriteToggle: () {
                          print('تم الضغط على المفضلة للعنصر رقم $index');
                        },
                        icons: Icons.close,
                        discount: "50",
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10,),
              CustomTitleSection(title: "Fast food",),
              const SizedBox(height: 10,),

              Container(
                height: 320.h,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8), // مسافة يمين ويسار
                      child: RestaurantCard(
                        imageUrl: "assets/images/004.jpg",
                        name: "Chicken King_Alhamra",
                        rating: 4.9,
                        orders: "500+ Order",
                        time: "20M",
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: RestaurantCard(
                        imageUrl: "assets/images/002.jpg",
                        name: "Chicken King_Alhamra",
                        rating: 4.9,
                        orders: "500+ Order",
                        time: "20M",
                        isClosed: true,
                        closedText: "Open tomorrow at 09:00 AM",
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: RestaurantCard(
                        imageUrl: "assets/images/003.jpg",
                        name: "Chicken King_Alhamra",
                        rating: 4.9,
                        orders: "500+ Order",
                        time: "20M",
                      ),
                    ),
                  ],
                ),
              )





            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNav(),
    );
  }
}
