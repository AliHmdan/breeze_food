import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/screens/add_order/payment_method.dart';
import 'package:breezefood/presentation/widgets/custom_pill_input.dart';
import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:breezefood/presentation/widgets/request_order/delvery_location.dart';
import 'package:breezefood/presentation/widgets/request_order/meal_card.dart';
import 'package:breezefood/presentation/widgets/request_order/product_option.dart';
import 'package:breezefood/presentation/widgets/request_order/title_location.dart';
import 'package:breezefood/presentation/widgets/request_order/total.dart';
import 'package:breezefood/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem {
  final String image; // asset path or network
  final String title;
  final String size; // e.g. "M"
  final double price;
  final int qty;

  const OrderItem({
    required this.image,
    required this.title,
    required this.size,
    required this.price,
    this.qty = 1,
  });

  double get total => price * qty;
}
class PayYourOrder extends StatefulWidget {
  const PayYourOrder({super.key});

  @override
  State<PayYourOrder> createState() => _PayYourOrderState();
}

class _PayYourOrderState extends State<PayYourOrder> {
   final List<OrderItem> _items = const [
    OrderItem(
      image: 'assets/images/food1.jpg',
      title: 'Chicken shish',
      size: 'M',
      price: 5.00,
      qty: 1,
    ),
    OrderItem(
      image: 'assets/images/food1.jpg',
      title: 'Chicken shish',
      size: 'M',
      price: 5.00,
      qty: 1,
    ),
  ];
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

//  late final List<String> _pngAssets;

@override
void initState() {
  super.initState();
  // مثال:
  // methods = [
  //   PaymentMethod(id:'cash', title:'Cash', imageAsset:'assets/icons/cash.png', imageWidth:36, imageHeight:24),
  //   PaymentMethod(id:'visa', title:'Visa card', imageAsset:'assets/icons/visa.png'),
  //   PaymentMethod(id:'master', title:'Master card', imageAsset:'assets/icons/mastercard.png'),
  // ];
  // _pngAssets = methods.map((m) => m.imageAsset).whereType<String>().toList();
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
  bool showCounter = false;
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
           const MealCard(
  image: 'assets/images/003.jpg',
  name: 'Chicken shish',
  size: 'M',
  price: 5.00,
  showCounter: false,
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


             

              // --- قسم الدفع ---
              PaymentMethodSection(
                amountText: '${total.toStringAsFixed(2)}\$',
                methods: methods,         // لا تستخدم const هنا
                initialSelectedId: 'cash',
                onChanged: (id) {
                  // تعامل مع تغيير الطريقة (Bloc/API) إن رغبت
                },
                onOrder: () {
                  Navigator.of(context).pushNamed(AppRoute.success);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
