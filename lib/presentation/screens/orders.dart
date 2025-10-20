import 'package:flutter/material.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';
import '../widgets/custom_appbar_home.dart';
import '../widgets/page_orders/current_orders.dart';
import '../widgets/page_orders/orders_history.dart';

// ... نفس الاستيرادات

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
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabHeader() {
    final titles = ["Current orders", "Orders history"];
    return Row(
      children: List.generate(2, (index) {
        final isSelected = _tabController.index == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => _tabController.animateTo(index),
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
                    margin: EdgeInsets.only(top: 4.h),
                    height: 3,
                    width: isSelected ? 130.w : 0,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColor.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
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
            _tabHeader(),
            SizedBox(height: 10.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(), // 👈 مهم
                children: const [
                  // بدّلهم بويدجتك الفعلية لو موجودة
                  CurrentOrders(),
                  OrdersHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
