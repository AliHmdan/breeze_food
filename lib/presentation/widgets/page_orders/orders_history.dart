import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrdersHistory extends StatelessWidget {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "restaurant": "Chicken House",
        "items": "2 items",
        "total": "25.00\$",
        "date": "25/5/2025 09:00 PM",
        "image": "assets/images/003.jpg",
      },
      {
        "restaurant": "Pizza Point",
        "items": "3 items",
        "total": "40.00\$",
        "date": "24/5/2025 08:30 PM",
        "image": "assets/images/004.jpg",
      },
    ];

    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = constraints.maxWidth; // عرض عنصر القائمة
              final actionTargetWidth = 80.w; // عرض زر Refresh
              final paneRatio = (actionTargetWidth / tileWidth).clamp(
                0.12,
                0.6,
              );

              final actionPane = ActionPane(
                motion: const DrawerMotion(),
                extentRatio: paneRatio,
                // 👇 المسافة بين الأزرار أو بين الزر والكارد
                dragDismissible: false,
                children: [
                  // فراغ صغير قبل الزر
                  SizedBox(width: 8.w),

                  CustomSlidableAction(
                    onPressed: (context) {
                      debugPrint("Refresh ${order["restaurant"]}");
                    },
                    backgroundColor: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(12),
                    flex: 1,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  // فراغ صغير بعد الزر (اختياري)
                  SizedBox(width: 8.w),
                ],
              );

              return Slidable(
                key: ValueKey(order["restaurant"]),
                startActionPane: isRTL ? actionPane : null,
                endActionPane: !isRTL ? actionPane : null,
                child: Container(
                  height: 110.h,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة
                      ClipOval(
                        child: Image.asset(
                          order["image"]!,
                          width: 70.w,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // تفاصيل الطلب
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSubTitle(
                              subtitle: order["restaurant"]!,
                              color: AppColor.white,
                              fontsize: 14.sp,
                            ),
                            CustomSubTitle(
                              subtitle: order["items"]!,
                              color: AppColor.white,
                              fontsize: 10.sp,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Total: ",
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 14.sp,
                                          fontFamily: "Manrope",
                                        ),
                                      ),
                                      TextSpan(
                                        text: order["total"],
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Manrope",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomSubTitle(
                                  subtitle: order["date"]!,
                                  color: AppColor.white,
                                  fontsize: 10.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
