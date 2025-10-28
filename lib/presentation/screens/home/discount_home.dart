import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/discount.dart';
import 'package:freeza_food/data/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountHome extends StatelessWidget {
  const DiscountHome({super.key, this.discounts});

  final List<DiscountModel>? discounts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
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
                    itemCount: (discounts != null && discounts!.isNotEmpty)
                        ? discounts!.length
                        : 5,
                    itemBuilder: (context, index) {
                      if (discounts != null && discounts!.isNotEmpty) {
                        final d = discounts![index];
                        final title = d.menuItems.isNotEmpty
                            ? d.menuItems.first.nameEn
                            : d.restaurant?.name ?? 'Discount';
                        final subtitle = d.restaurant?.name ?? '';
                        final price = d.discountValue.toString();
                        return Container(
                          width: itemWidth,
                          margin: EdgeInsets.only(right: 10.w),
                          child: Discount(
                            imagePath: 'assets/images/004.jpg',
                            title: title,
                            subtitle: subtitle,
                            price: price,
                            onFavoriteToggle: () {},
                            discount: d.discountValue.toString(),
                          ),
                        );
                      }

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
