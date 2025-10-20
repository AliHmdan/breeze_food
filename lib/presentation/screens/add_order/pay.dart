import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/add_order/food_item_card.dart';
import 'package:breezefood/presentation/widgets/add_order/payment.dart'; // تأكد أن PaymentMethodSelector يدعم shrinkWrap/physics
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
  final double subTotal = 30.00;
  final double delivery = 2.00;
  final double coupon = -4.99;

  @override
  Widget build(BuildContext context) {
    final double total = subTotal + delivery + coupon;

    return Scaffold(
      backgroundColor: AppColor.Dark,

      // ✅ استخدم AppBar مضبوط بدل pushNamedAndRemoveUntil
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomAppbarProfile(
              title: "Pay",
              icon: Icons.arrow_back_ios,
              ontap: () {
                // العودة الطبيعية لتجنّب أي Loop أو ثقل
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacementNamed("/home");
                }
              },
            ),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 6),

                // ✅ عناصر السلة (ثابتة هنا كمثال)
                const FoodItemCard(
                  title: "Chicken shish",
                  size: "M",
                  price: "1200",
                  image: "assets/images/shesh.jpg",
                ),
                const FoodItemCard(
                  title: "Chicken shish",
                  size: "M",
                  price: "1200",
                  image: "assets/images/shesh.jpg",
                ),

                const SizedBox(height: 10),

                // ✅ المجموعات
                Container(
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
                      const Divider(color: Colors.white30, height: 18),
                      Total("Total", total, isTotal: true),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ✅ عنوان طريقة الدفع + المبلغ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSubTitle(
                      subtitle: "Payment method",
                      color: AppColor.light,
                      fontsize: 16.sp,
                    ),
                    CustomSubTitle(
                      // يمكنك عرض total بدلاً من قيمة ثابتة
                      subtitle: "${total.toStringAsFixed(2)}\$",
                      color: AppColor.yellow,
                      fontsize: 16.sp,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ✅ ويدجت الدفع
                // ملاحظة مهمة: لو داخل PaymentMethodSelector يوجد ListView،
                // عدّلها لتستخدم: shrinkWrap: true, physics: NeverScrollableScrollPhysics()
                // أو مرّر له بارامترات مماثلة هنا إن كان يدعمها.
                 PaymentMethodSelector(), // اجعلها const إن أمكن

                const SizedBox(height: 12),

                // ✅ زر الدفع
                CustomButton(
                  title: "Pay",
                  onPressed: () {
                    Navigator.pushNamed(context, "/success");
                  },
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
