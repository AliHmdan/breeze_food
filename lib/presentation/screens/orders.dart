import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';
import '../widgets/custom_appbar_home.dart';
import '../widgets/page_orders/current_orders.dart';
import '../widgets/page_orders/orders_history.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppbarHome(title: "Orders"),
            SizedBox(height: 20.h),

            // 🔥 Animated TabBar
            Row(
              children: List.generate(2, (index) {
                final isSelected = _tabController.index == index;
                final titles = ["Current orders", "Orders history"];

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(index);
                      setState(() {});
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomSubTitle(
                            subtitle: titles[index],
                            color: isSelected ? AppColor.primaryColor : AppColor.white,
                            fontsize: 14.sp,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.only(
                              top: 4.h,
                            ), // مسافة صغيرة بين النص والخط
                            height: 3, // سمك الخط
                            width: isSelected
                                ? 130.w
                                : 0, // يخليه يتوسع مع عرض النص
                            constraints: BoxConstraints(
                              minWidth: 0,
                              maxWidth: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 10.h),

            // محتوى التبويبات
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [CurrentOrders(), OrdersHistory()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
