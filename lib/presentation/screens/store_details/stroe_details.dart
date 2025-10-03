import 'package:breezefood/presentation/screens/add_order/add_order.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';
import '../../widgets/home/custom_title_section.dart';
import '../../widgets/home/most_popular.dart';
import '../../widgets/tiem_price.dart';

class StoreDetails extends StatelessWidget {
  final List<String> categories;

  const StoreDetails({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColor.Dark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// صورة المتجر
            SizedBox(
              height: 280.h,
              width: double.infinity,
              child: Image.asset(
                "assets/images/shawarma_box.png",
                fit: BoxFit.cover,
              ),
            ),

            /// المحتوى
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🕑 الوقت + 🚚 التوصيل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TiemPrice(
                         svgPath: "assets/icons/time.svg",
                        title: "15-40",
                        subtitle: "min",
                      ),
                      TiemPrice(
                        title: "2.00",
                        subtitle: "\$",
                        svgPath: "assets/icons/motor.svg",
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
            
                  /// 🏷️ العنوان
                  Center(
                    child: CustomTitle(
                      title: "Shawarma King",
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
            
                  /// ⭐ الوصف + التقييم + عدد الطلبات
                  Row(
                    children: [
                      Expanded(
                        child: CustomSubTitle(
                          subtitle: "Lorem ipsum dolor sit amet consectetur.",
                          color: AppColor.gry,
                          fontsize: 10.sp,
                        ),
                      ),
                      Container(
                        width: 1.w,
                        height: 20.h,
                        color: AppColor.light,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 2.w),
                      Text(
                        "4.9",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                        ),
                      ),
                      Container(
                        width: 1.w,
                        height: 20.h,
                        color: AppColor.light,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                      ),
                      Text(
                        "500+ Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
            
                  /// ✅ التصنيفات
                  Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 10.h,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Container(
                              //  height: 50.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.Dark,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: CustomSubTitle(
                                  subtitle: categories[index],
                                  color: AppColor.white,
                                  fontsize: 12.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
            
                  /// ✅ Order again
                  CustomTitleSection(title: "Order again"),
                  SizedBox(height: 10.h),
            
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOrder(
                            title: "Chicken",
                            price: "5.00\$",
                            oldPrice: "5.00\$",
                            imagePath: "assets/images/004.jpg",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColor.LightActive,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      height: 200.h,
                      width: 176.w,
                      child: PopularItemCard(
                        imagePath: "assets/images/004.jpg",
                        title: "Chicken ",
                        price: "5.00\$",
                        oldPrice: "5.00\$",
                        onFavoriteToggle: () {},
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
            
                  /// ✅ Customer Favorite
                  CustomTitleSection(
                    title: "Customer Favorite",
                    all: "All",
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  SizedBox(height: 10.h),
            
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.LightActive,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    height: 205.h,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double itemWidth = constraints.maxWidth / 2.2;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: itemWidth,
                              margin: EdgeInsets.only(right: 10.w),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddOrder(
                                        title: "Chicken",
                                        price: "5.00\$",
                                        oldPrice: "5.00\$",
                                        imagePath: "assets/images/shesh.jpg",
                                      ),
                                    ),
                                  );
                                },
                                child: PopularItemCard(
                                  imagePath: 'assets/images/shesh.jpg',
                                  title: 'Chicken',
                                  price: '5.00\$',
                                  oldPrice: "5.00\$",
                                  onFavoriteToggle: () {
                                    print(
                                      'تم الضغط على المفضلة للعنصر رقم $index',
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),
            
                  /// ✅ Shawarma Section
                  CustomTitleSection(
                    title: "Shawarma",
                    all: "All",
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.LightActive,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    height: 205.h,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double itemWidth = constraints.maxWidth / 2.2;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: itemWidth,
                              margin: EdgeInsets.only(right: 10.w),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddOrder(
                                        title: "Chicken",
                                        price: "5.00\$",
                                        oldPrice: "5.00\$",
                                        imagePath: "assets/images/shesh.jpg",
                                      ),
                                    ),
                                  );
                                },
                                child: PopularItemCard(
                                  imagePath: 'assets/images/shesh.jpg',
                                  title: 'Chicken',
                                  price: '5.00\$',
                                  oldPrice: "5.00\$",
                                  onFavoriteToggle: () {
                                    print(
                                      'تم الضغط على المفضلة للعنصر رقم $index',
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
