import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/add_order/counter.dart';
import 'package:freeza_food/presentation/widgets/add_order/custom_add.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/add_order/gradient_rectSlider_track_shape.dart';

class AddOrder extends StatefulWidget {
  final String title;
  final String price;
  final String imagePath;
  final String oldPrice;
  const AddOrder({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.oldPrice,
  });

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final List<String> sizes = ["S", "M", "L"];

  // 👇 لازم تعريفها
  // final Set<String> _selectedSizes = {}; // يدعم اختيار أكثر من حجم
  String? _selectedSize;
  bool chipsSelected = false;
  bool riceSelected = false;

  double _value = 0.8; // القيمة الافتراضية; (من 0 إلى 1)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: CustomArrow(
            onTap: () {
              Navigator.pop(context);
            },
            color: AppColor.white,
            background: AppColor.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    // "assets/images/004.jpg",
                    widget.imagePath,
                    width: double.infinity,
                    height: 220.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColor.white,
                      child: SvgPicture.asset(
                        "assets/icons/share.svg",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👇 العنوان + الأسعار
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      CustomSubTitle(
                        subtitle: widget.title,
                        color: AppColor.white,
                        fontsize: 16.sp,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.oldPrice,
                            style: TextStyle(
                              color: AppColor.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              fontFamily: "Manrope",
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColor.red,
                              decorationThickness: 2,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            widget.price,
                            style: TextStyle(
                              color: AppColor.yellow,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              fontFamily: "Manrope",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomSubTitle(
                    subtitle: "Lorem ipsum dolor sit amet  Et diam mauris",
                    color: AppColor.gry,
                    fontsize: 10.sp,
                  ),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      color: AppColor.gry,
                      thickness: 1.2,
                      height: 40,
                    ),
                  ),

                  // الأحجام (S, M, L)
                  Row(
                    children: sizes.map((size) {
                      final bool isSelected = _selectedSize == size;
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedSize = null;
                              } else {
                                _selectedSize = size;
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: isSelected
                                ? AppColor.primaryColor
                                : AppColor.white,
                            child: CustomSubTitle(
                              subtitle: size,
                              color: isSelected ? Colors.white : AppColor.Dark,
                              fontsize: 18.sp,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  CustomSubTitle(
                    subtitle: "Add a?",
                    color: AppColor.white,
                    fontsize: 16.sp,
                  ),
                  CustomAdd(),
                  SizedBox(height: 5),
                  CustomSubTitle(
                    subtitle: "Hot",
                    color: AppColor.white,
                    fontsize: 16.sp,
                  ),
                  Center(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8,
                        thumbColor: AppColor.primaryColor, // 👈 لون دائرة السحب
                        overlayColor: AppColor.primaryColor.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 16,
                        ),
                        trackShape:
                            const GradientRectSliderTrackShape(), // 👈 التراك مخصص
                      ),
                      child: Slider(
                        min: 0,
                        max: 1,
                        value: _value,
                        onChanged: (val) {
                          setState(() {
                            _value = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      color: AppColor.gry,
                      thickness: 1.2,
                      height: 40,
                    ),
                  ),

                  Counter(),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
