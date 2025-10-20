import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/screens/add_order/payment_method.dart';
import 'package:breezefood/presentation/widgets/custom_pill_input.dart';
import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:breezefood/presentation/widgets/request_order/coupon.dart';
import 'package:breezefood/presentation/widgets/request_order/meal_card.dart';
import 'package:breezefood/presentation/widgets/request_order/total.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
  final methods = [
  const PaymentMethod(
    id: 'cash',
    title: 'Cash',
    imageAsset: 'assets/images/cash.png',
    imageWidth: 36,
    imageHeight: 24,
  ),
  const PaymentMethod(
    id: 'visa',
    title: 'Visa card',
    imageAsset: 'assets/images/visa.png',
  ),
  const PaymentMethod(
    id: 'master',
    title: 'Master card',
    imageAsset: 'assets/images/master.png',
  ),
];

  double subTotal = 30.00;
  double delivery = 2.00;
  double coupon = -4.99;

  // late final List<PaymentMethod> methods; // ⬅️ سنملؤها في initState

 late final List<String> _pngAssets;

@override
void initState() {
  super.initState();
  // مثال:
  // methods = [
  //   PaymentMethod(id:'cash', title:'Cash', imageAsset:'assets/icons/cash.png', imageWidth:36, imageHeight:24),
  //   PaymentMethod(id:'visa', title:'Visa card', imageAsset:'assets/icons/visa.png'),
  //   PaymentMethod(id:'master', title:'Master card', imageAsset:'assets/icons/mastercard.png'),
  // ];
  _pngAssets = methods.map((m) => m.imageAsset).whereType<String>().toList();
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final dpr = MediaQuery.of(context).devicePixelRatio;
  for (final m in methods) {
    final path = m.imageAsset;
    if (path == null) continue;
    final w = (m.imageWidth.w * dpr).round();
    final h = (m.imageHeight.h * dpr).round();
    precacheImage(
      ResizeImage(AssetImage(path), width: w, height: h),
      context,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final double total = subTotal + delivery + coupon;

    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomAppbarProfile(
            title: "Shawarma King",
            icon: Icons.arrow_back_ios,
            ontap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            children: [
              const MealCard(),
              const SizedBox(height: 8),

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

              const SizedBox(height: 8),

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubTitle(
                      subtitle: "Want a ?",
                      color: AppColor.white,
                      fontsize: 16,
                    ),
                    SizedBox(height: 5),
                    ProudectOption(),
                  ],
                ),
              ),

              const SizedBox(height: 8),

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
                    const Divider(color: Colors.white30),
                    Total("Total", total, isTotal: true),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const CustomTitleSection(title: "Delivery to"),
              const TitleLocation(),
              const SizedBox(height: 10),
              const DeliveryLocationCard(),

              const SizedBox(height: 10),

              Row(
                children: [
                  CustomPillInput(
                    hint: 'Floor number',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    width: 130.w,
                  ),
                  SizedBox(width: 10.w),
                  CustomPillInput(
                    hint: 'Door number',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    width: 130.w,
                  ),
                ],
              ),

              // --- قسم الدفع ---
              PaymentMethodSection(
                amountText: '${total.toStringAsFixed(2)}\$',
                methods: methods,         // لا تستخدم const هنا
                initialSelectedId: 'cash',
                onChanged: (id) {
                  // تعامل مع تغيير الطريقة (Bloc/API) إن رغبت
                },
                onOrder: () {
                  // تنفيذ الطلب
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
