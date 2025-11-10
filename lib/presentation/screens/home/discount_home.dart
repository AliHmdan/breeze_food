import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/screens/add_order/add_order.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/discount.dart';
import 'package:freeza_food/data/model/home_model.dart' as home_model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountHome extends StatelessWidget {
  final List<home_model.DiscountModel>? discounts;

  const DiscountHome({super.key, this.discounts});

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
            ontap: () =>
                Navigator.of(context).pushNamed(AppRoute.discountDetails),
          ),
          const SizedBox(height: 10),
          RepaintBoundary(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final items = discounts ?? <home_model.DiscountModel>[];
                final count = items.length;
                final gap = 10.w;
                final maxW = constraints.maxWidth;

                // padding ديناميكي
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

                // عرض الكرت
                final cardWidth = maxW / 2.3;

                // عرض الحاوية
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

                if (items.isEmpty) {
                  return Container(
                    height: 160,
                    alignment: Alignment.center,
                    child: Text(
                      "No discounts available",
                      style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                    ),
                  );
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
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final d = items[index];
                        final menuItem = d.menuItems.isNotEmpty
                            ? d.menuItems.first
                            : null;

                        // ✅ الصورة من API: نحاول من DiscountModel.imageUrl ثم من أول menuItem.imageUrl
                        final String imagePath =
                            (d.imageUrl != null && d.imageUrl!.isNotEmpty)
                            ? d.imageUrl!
                            : "assets/images/004.jpg";

                        final String title =
                            (menuItem?.nameEn?.trim().isNotEmpty ?? false)
                            ? menuItem!.nameEn!
                            : (menuItem?.nameAr ?? "Item");

                        final String subtitle = d.restaurant?.name ?? "";

                        // عرض نص الخصم (يمكنك تغييره حسب نوع الخصم)
                        final String discountText = d.discountType == "percent"
                            ? "-${d.discountValue}%"
                            : "-${d.discountValue}";

                        return Container(
                          width: cardWidth,
                          margin: EdgeInsets.only(right: gap),
                          child: GestureDetector(
                            onTap: () {
                              showAddOrderDialog(
                                context,
                                title: title,
                                price:
                                    "5.00\$", // عدّلها حسب سعر العنصر لو متاح
                                oldPrice:
                                    "5.00\$", // عدّلها لعرض السعر قبل الخصم
                                imagePath: imagePath, // ✅ صورة من API
                              );
                            },
                            child: Discount(
                              imagePath: imagePath, // ✅ صورة من API
                              title: title,
                              subtitle: subtitle,
                              price:
                                  discountText, // يمكنك وضع السعر بدلًا من الخصم هنا
                              discount:
                                  discountText, // النص الظاهر كـ Tag مثلاً
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
