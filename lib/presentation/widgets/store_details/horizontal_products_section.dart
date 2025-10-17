import 'package:breezefood/presentation/screens/add_order/add_order.dart';
import 'package:breezefood/presentation/widgets/home/most_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constans/color.dart';


class HorizontalProductsSection extends StatelessWidget {
  final int itemCount;
  final String imagePath;
  final String title;
  final String price;
  final String oldPrice;

  const HorizontalProductsSection({
    super.key,
    this.itemCount = 5,
    this.imagePath = 'assets/images/shesh.jpg',
    this.title = 'Chicken',
    this.price = '5.00\$',
    this.oldPrice = '5.00\$',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(
                    top: 10,
                    bottom: 8,
                    left: 8,
                    right: 0.2,
                  ),
      decoration: BoxDecoration(
        color: AppColor.LightActive,
        borderRadius: BorderRadius.circular(15.r),
      ),
      height: 173.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 2.2;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () {
                    showAddOrderDialog(
                      context,
                      title: title,
                      price: price,
                      oldPrice: oldPrice,
                      imagePath: imagePath,
                    );
                  },
                  child: PopularItemCard(
                    imagePath: imagePath,
                    title: title,
                    price: price,
                    oldPrice: oldPrice,
                    onFavoriteToggle: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
