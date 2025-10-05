import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/screens/search.dart';
import 'package:breezefood/presentation/widgets/home/Stores.dart';
import 'package:breezefood/presentation/widgets/button/custom_button_order.dart';
import 'package:breezefood/presentation/widgets/auth/custom_search.dart';

import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/CustomBottomNav.dart';
import '../../widgets/custom_appbar_home.dart';
import '../../widgets/home/custom_carousel_slider.dart';
import '../../widgets/home/custom_fast_food.dart';
import '../../widgets/home/discount.dart';
import '../../widgets/home/most_popular.dart';

import '../discount_grid_Page.dart';

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

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbarHome(
                  title: "Deliver to",
                  subtitle: "Poplar Ave,CA",
                  image: "assets/icons/location.svg",
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.profile);
                  },
                  icon: Icons.keyboard_arrow_down,
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Search()));
                  },
                  child: CustomSearch(hint: "Search"),
                ),
                SizedBox(height: 20),
                BrunchCarousel(),
                const SizedBox(height: 15),
                CustomTitleSection(
                  title: "Most popular",
                  all: "All",
                  icon: Icons.arrow_forward_ios_outlined,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        
                  decoration: BoxDecoration(
                    color: AppColor.LightActive,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 199.h,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = constraints.maxWidth / 2.3;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: itemWidth,
                            margin: EdgeInsets.only(right: 10.w),
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
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomTitleSection(title: "Stores"),
                Stores(),
                SizedBox(height: 2.h),
                // RatingStores(),
                const SizedBox(height: 10),
                CustomTitleSection(
                  title: "Discounts",
                  all: "All",
                  icon: Icons.arrow_forward_ios_outlined,
                  ontap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DiscountGridPage()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        
                  decoration: BoxDecoration(
                    color: AppColor.LightActive,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 199.h,
        
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = constraints.maxWidth / 2.3;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: itemWidth,
                            margin: EdgeInsets.only(right: 10.w),
        
                            child: Discount(
                              imagePath: 'assets/images/004.jpg',
                              title: 'Chicken shish without...',
                              subtitle: 'burger king',
                              price: '2.00\$',
                              onFavoriteToggle: () {
                                print('تم الضغط على المفضلة للعنصر رقم $index');
                              },
                              // icons: Icons.close,
                              discount: "50",
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomTitleSection(title: "Fast food"),
                const SizedBox(height: 10),
        
                Stack(
                  clipBehavior: Clip.none, // ضروري حتى يظهر الزر خارج الحاوية
                  children: [
                    Container(
                      height: 320.h,
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.LightActive,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
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
                    ),
                       // الزر في المنتصف ويطفو فوق الحافة
                       Positioned(
                      bottom: 85, // نصف الزر تحت الحافة
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CustomButtonOrder(
                          title: "Your order",
                          onPressed: () {},
                        ),
                      ),
                    ), 
          /// Bottom Navigation عائم
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child:Custombottomnav()
          ),
                 
                 
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}
