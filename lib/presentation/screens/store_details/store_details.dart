import 'dart:ui';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/screens/add_order/add_order.dart';
import 'package:freeza_food/presentation/widgets/auth/custom_search.dart';
import 'package:freeza_food/presentation/widgets/store_details/horizontal_products_section.dart';
import 'package:freeza_food/presentation/widgets/store_details/pinch_zoom_header.dart';
import 'package:freeza_food/presentation/widgets/store_details/shadows.dart';
import 'package:freeza_food/presentation/widgets/store_details/v_divider.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:freeza_food/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constans/color.dart';
import '../../widgets/home/custom_title_section.dart';
import '../../widgets/home/most_popular.dart';
import '../../widgets/tiem_price.dart';



class StoreDetails extends StatefulWidget {
  final List<String> categories;

  const StoreDetails({super.key, required this.categories});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ========= الهيدر (الصورة مع التكبير والـ gradient) =========
            PinchZoomHeader(
              imagePath: "assets/images/shawarma_box.png",
              height: 200.h,
              maxScale: 1.25,
            ),

            // ========= محتوى الصفحة مع ظلّ واضح عند الحافّة العلوية =========
            Transform.translate(
              offset: Offset(0, -16.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.Dark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),
                  boxShadow: const [kLiftedEdgeShadow], // ← الظل مفصول بملف
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                 
                      /// 🕑 الوقت + 🚚 التوصيل
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TiemPrice(
                            svgPath: "assets/icons/time.svg",
                            title: "15-40",
                            subtitle: "min",
                          ),
                          const TiemPrice(
                            title: "2.00",
                            subtitle: "\$",
                            svgPath: "assets/icons/motor.svg",
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      /// 🏷️ العنوان
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Spacer(),
                          Center(
                            child: CustomTitle(
                              title: "Shawarma King",
                              color: AppColor.white,
                            ),
                          ),
                          Spacer(),
                          IconButton(onPressed: (){
                                                Navigator.of(context).pushNamed(AppRoute.search);

                          }, icon: SvgPicture.asset(
                            'assets/icons/search.svg',
                            color: AppColor.white,
                            width: 20.w,
                            height: 20.w,
                          ),)
                        ],
                      ),
                      SizedBox(height: 6.h),

                      /// ⭐ الوصف + التقييم + عدد الطلبات
                      Row(
                        children: [
                          Expanded(
                            child: CustomSubTitle(
                              subtitle: "Lorem ipsum dolor sit amet consectetur.",
                              color: AppColor.gry,
                              fontsize: 10.sp,
                            ),
                          ),
                          const VDividerThin(),
                          Icon(Icons.star, color: AppColor.yellow, size: 16.sp),
                          SizedBox(width: 2.w),
                          Text("4.9",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 11.sp)),
                          const VDividerThin(),
                          Text("500+ Order",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 11.sp)),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      /// ✅ التصنيفات (chips)
                      Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 10.h),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.categories.length,
                          separatorBuilder: (_, __) => SizedBox(width: 8.w),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColor.Dark,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: CustomSubTitle(
                                  subtitle: widget.categories[index],
                                  color: AppColor.white,
                                  fontsize: 12.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// ✅ Order again
                      const CustomTitleSection(title: "Order again"),
                      SizedBox(height: 10.h),

                      GestureDetector(
                        onTap: () {
                          showAddOrderDialog(
                            context,
                            title: "Chicken",
                            price: "5.00\$",
                            oldPrice: "5.00\$",
                            imagePath: "assets/images/004.jpg",
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: AppColor.LightActive,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          height: 163.h,
                          width: 160.w,
                          child: PopularItemCard(
                            imagePath: "assets/images/004.jpg",
                            title: "Chicken ",
                            price: "5.00\$",
                            oldPrice: "5.00\$",
                            onFavoriteToggle: () {},
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// ✅ Customer Favorite
                      const CustomTitleSection(
                        title: "Customer Favorite",
                        all: "All",
                        icon: Icons.arrow_forward_ios_outlined,
                      ),
                      SizedBox(height: 10.h),

                      const HorizontalProductsSection(),

                      SizedBox(height: 16.h),

                      /// ✅ Shawarma Section
                      const CustomTitleSection(
                        title: "Shawarma",
                        all: "All",
                        icon: Icons.arrow_forward_ios_outlined,
                      ),
                      SizedBox(height: 10.h),

                      const HorizontalProductsSection(),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
