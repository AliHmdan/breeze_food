import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:breezefood/presentation/widgets/request_order/coupon.dart';
import 'package:breezefood/presentation/widgets/request_order/custom_buttom_map.dart';
import 'package:breezefood/presentation/widgets/request_order/meal_card.dart';
import 'package:breezefood/presentation/widgets/request_order/total.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/request_order/delvery_location.dart';
import '../../widgets/request_order/product_option.dart';
import '../../widgets/request_order/title_location.dart';
import '../../widgets/title/custom_appbar_profile.dart';

class RequestOrder extends StatefulWidget {
  const RequestOrder({super.key});

  @override
  State<RequestOrder> createState() => _RequestOrderState();
}

class _RequestOrderState extends State<RequestOrder> {
  double subTotal = 30.00;
  double delivery = 2.00;
  double coupon = -4.99;
  @override
  Widget build(BuildContext context) {
    double total = subTotal + delivery + coupon;
    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h), // ارتفاع الـ AppBar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomAppbarProfile(
            title: "Shawarma King",
            icon: Icons.arrow_back_ios,
            ontap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            children: [
              MealCard(),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.add, color: AppColor.primaryColor, size: 20.sp),
                  CustomSubTitle(
                    subtitle: "Add",
                    color: AppColor.primaryColor,
                    fontsize: 14.sp,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubTitle(
                      subtitle: "Want a ?",
                      color: AppColor.white,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 5),
                    ProudectOption(),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubTitle(
                      subtitle: "Coupon",
                      color: AppColor.white,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 5),
                    CouponCard(code: "Q345FCXC"),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Total("Sub total", subTotal),
                    Total("Delivery", delivery),
                    Total("Coupon", coupon),
                    const Divider(color: Colors.white30),
                    Total("Total", total, isTotal: true),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomTitleSection(title: "Delivery to"),
              const TitleLocation(),
              SizedBox(height: 10),
              DeliveryLocationCard(),
              SizedBox(height: 10),
              Row(
                children: [
                  // Floor number
                 CustomButtomMap(title: "Floor number",),
                  SizedBox(width: 8.w),

                  // Door number
                  CustomButtomMap(title: "Door number",),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
