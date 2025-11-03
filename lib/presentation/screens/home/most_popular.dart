import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/screens/add_order/add_order.dart';
import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:breezefood/presentation/widgets/home/most_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
 padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
       child: Column(
        children: [
            
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
                              child: GestureDetector(
                                onTap: () {
                                   showAddOrderDialog(
                            context,
                            title: "Chicken",
                            price: "5.00\$",
                            oldPrice: "5.00\$",
                            imagePath: "assets/images/004.jpg",
                          );
                                },
                                child: PopularItemCard(
                                  imagePath: 'assets/images/004.jpg',
                                  title: 'Chicken shish without...',
                                  subtitle: 'burger king',
                                  price: '2.00\$',
                                  onFavoriteToggle: () {},
                                ),
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