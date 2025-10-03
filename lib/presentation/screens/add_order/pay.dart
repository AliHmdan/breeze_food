import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/add_order/food_item_card.dart';
import 'package:breezefood/presentation/widgets/add_order/payment.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/request_order/total.dart';
import 'package:breezefood/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
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
            title: "Pay",
            icon: Icons.arrow_back_ios,
            ontap: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("/home", (route) => false);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FoodItemCard(
                title: "Chicken shish",
                size: "M",
                price: "1200",
                image: "assets/images/shesh.jpg",
              ),
              FoodItemCard(
                title: "Chicken shish",
                size: "M",
                price: "1200",
                image: "assets/images/shesh.jpg",
              ),
              SizedBox(height: 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubTitle(
                    subtitle: "Payment method",
                    color: AppColor.light,
                    fontsize: 16.sp,
                  ),
                  CustomSubTitle(
                    subtitle: "15.00\$",
                    color: AppColor.yellow,
                    fontsize: 16.sp,
                  ),
                ],
              ),
              PaymentMethodSelector(),
                  SizedBox(height: 10),
              CustomButton(title: "Pay", onPressed: (){
                Navigator.pushNamed(context, "/success");

              })
            ],
          ),
        ),
      ),
    );
  }
}
