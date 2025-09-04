import 'package:breezefood/presentation/screens/add_order/add_order.dart';
import 'package:breezefood/presentation/screens/add_order/request_order.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';
import '../../widgets/home/custom_title_section.dart';
import '../../widgets/home/most_popular.dart';
import '../../widgets/tiem_price.dart';

class AddNewMeal extends StatelessWidget {
  final List<String> categories; // ⬅️ تعريف ليست الكاتيجوري

  const AddNewMeal({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      // appBar: AppBar(
      //   backgroundColor: AppColor.white,
      //   title: Padding(
      //     padding: EdgeInsets.symmetric(vertical: 20.h),
      //     child: SizedBox(
      //       width: double.infinity,
      //       child: Image.asset("assets/images/shawarma_box.png"),
      //     ),
      //   ),
      //   toolbarHeight: 200.h,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              child: Image.asset("assets/images/shawarma_box.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🕑 الوقت + 🚚 التوصيل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TiemPrice(
                        icon: Icons.alarm,
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
                  // 🏷️ العنوان
                  Center(
                    child: CustomTitle(
                      title: "Shawarma King",
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // ⭐ الوصف + التقييم + عدد الطلبات
                  Row(
                    children: [
                      // النص
                      Expanded(
                        child: CustomSubTitle(
                          subtitle: "Lorem ipsum dolor  amet consectetur.",
                          color: AppColor.gry,
                          fontsize: 8.sp,
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 20.h,
                        color: AppColor.light,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                      ),

                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 2),
                      const Text(
                        "4.9",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),

                      Container(
                        width: 1,
                        height: 20.h,
                        color: AppColor.light,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                      ),

                      const Text(
                        "500+ Order",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),

                  // ✅ التصنيفات
                  Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 10.h,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: AppColor.Dark,
                                  borderRadius: BorderRadius.circular(20),
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
                  ),

                  SizedBox(height: 10),
                  CustomTitleSection(title: "Order again"),
                  SizedBox(height: 10),

                  // ✅ عنصر واحد
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
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 203.h,
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

                  SizedBox(height: 10),
                  CustomTitleSection(
                    title: "Customer Favorite",
                    all: "All",
                    icon: Icons.arrow_forward_ios_outlined,
                  ),
                  SizedBox(height: 5),

                  // ✅ ليستة
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 203.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
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
                            child: PopularItemCard(
                              imagePath: 'assets/images/004.jpg',
                              title: 'Chicken',
                              price: '5.00\$',
                              oldPrice: "5.00\$",
                              onFavoriteToggle: () {
                                print('تم الضغط على المفضلة للعنصر رقم $index');
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  CustomButton(
                    title: "View Cart    5.00\$",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RequestOrder()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
