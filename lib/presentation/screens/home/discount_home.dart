import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountHome extends StatelessWidget {
  const DiscountHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
padding: const EdgeInsets.only(top: 5,left: 10,right: 10),      child: Column(
        children: [
           CustomTitleSection(
                  title: "Discounts",
                  all: "All",
                  icon: Icons.arrow_forward_ios_outlined,
                  ontap: () {
                    Navigator.of(context).pushNamed(AppRoute.discountDetails);
                  },
                ),
                const SizedBox(height: 10),
                RepaintBoundary(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 8,
                      right: 0.2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.LightActive,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 178,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final itemWidth = constraints.maxWidth / 2.3;
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
                                onFavoriteToggle: () {},
                                discount: "50",
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}