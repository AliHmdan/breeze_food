import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/screens/add_order/add_order.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/most_popular.dart';
import 'package:freeza_food/data/model/home_model.dart' as home_model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostPopular extends StatelessWidget {
  final List<home_model.MenuItemModel>? popular;

  const MostPopular({super.key, this.popular});

  @override
  Widget build(BuildContext context) {
    print("MostPopular rebuilt $popular");
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        children: [
          CustomTitleSection(
            title: "Most popular",
            all: "All",
            icon: Icons.arrow_forward_ios_outlined,
            ontap: () {
              Navigator.of(context).pushNamed(AppRoute.PopularGridPage);
            },
          ),
          const SizedBox(height: 10),
          RepaintBoundary(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final items = popular ?? [];
                final count = items.length;
                final gap = 10.w;
                final maxW = constraints.maxWidth;

                // ✅ ضبط البادينغ حسب الشرط الجديد:
                // 1 أو 2 عنصر  → right = 8
                // أكثر من 2   → right = 0.1
                final EdgeInsets boxPadding = (count <= 2)
                    ? const EdgeInsets.only(
                        top: 6,
                        bottom: 6,
                        left: 6,
                        right: 6,
                      )
                    : const EdgeInsets.only(
                        top: 6,
                        bottom: 6,
                        left: 6,
                        right: 0.5,
                      );

                // عرض البطاقة
                final cardWidth = maxW / 2.3;

                // ✅ حساب عرض الحاوية بناءً على عدد العناصر
                double containerWidth;
                if (count == 0) {
                  containerWidth = maxW;
                } else if (count == 1) {
                  containerWidth = (boxPadding.horizontal + cardWidth).clamp(
                    0.0,
                    maxW,
                  );
                } else if (count == 2) {
                  containerWidth =
                      (boxPadding.horizontal + (2 * cardWidth) + gap).clamp(
                        0.0,
                        maxW,
                      );
                } else {
                  containerWidth = maxW;
                }

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: boxPadding,
                    height: 171,
                    width: containerWidth,
                    decoration: BoxDecoration(
                      color: AppColor.LightActive,
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: count,
                      itemBuilder: (context, index) {
                        final it = items[index];
                        return Container(
                          width: cardWidth,
                          margin: EdgeInsets.only(right: gap),
                          child: GestureDetector(
                            onTap: () {
                              showAddOrderDialog(
                                context,
                                title: it.name ?? "Chicken",
                                price: (it.basePrice ?? '').toString(),
                                oldPrice: (it.basePrice ?? '').toString(),
                                imagePath:
                                    it.primaryImageUrl ??
                                    "assets/images/004.jpg",
                              );
                            },
                            child: PopularItemCard(
                              isFavorite: it.isFavorite,
                              imagePath: it.primaryImageUrl ?? '',
                              title: it.name ?? '',
                              subtitle: (it.restaurantId ?? '').toString(),
                              price: (it.basePrice ?? '').toString(),
                              onFavoriteToggle: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
