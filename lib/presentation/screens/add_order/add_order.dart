import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/add_order/counter.dart';
import 'package:breezefood/presentation/widgets/add_order/custom_add.dart';
import 'package:breezefood/presentation/widgets/add_order/custom_hot.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// استدعِ هذه الدالة عند النقر على الكارد/الكونتينر
Future<void> showAddOrderDialog(
  BuildContext context, {
  required String title,
  required String price,
  required String oldPrice,
  required String imagePath,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: 50), // ✅ جعل الديالوج بعرض الشاشة بالكامل
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r), // بدون حواف لتغطية العرض بالكامل
          child: Material(
            color: AppColor.Dark,
            child: SizedBox(
              width: MediaQuery.of(context).size.width, // ✅ يأخذ عرض الشاشة
              height: MediaQuery.of(context).size.height *1.0, // ارتفاع تقريبي
              child: AddOrderBody(
                title: title,
                price: price,
                oldPrice: oldPrice,
                imagePath: imagePath,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


/// نفس تصميم الصفحة لكن بدون Scaffold/AppBar ليتناسب مع الـ Dialog
class AddOrderBody extends StatefulWidget {
  final String title;
  final String price;
  final String imagePath;
  final String oldPrice;

  const AddOrderBody({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.oldPrice,
  });

  @override
  State<AddOrderBody> createState() => _AddOrderBodyState();
}

class _AddOrderBodyState extends State<AddOrderBody> {
  final List<String> sizes = ["S", "L"];
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // صورة المنتج + زر إغلاق
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.asset(
                  widget.imagePath,
                  width: double.infinity,
                  height: 220.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black54),
                  ),
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    _showShareOptions(context);
                  },
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
              ),
            ],
          ),

          SizedBox(height: 8.h),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان + الأسعار
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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

                // الأحجام S / M / L
                Row(
                  children: sizes.map((size) {
                    final isSelected = _selectedSize == size;
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _selectedSize = isSelected ? null : size;
                        }),
                        child: CircleAvatar(
                          radius: 15,
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

                SizedBox(height: 12.h),

                CustomSubTitle(
                  subtitle: "Add a?",
                  color: AppColor.white,
                  fontsize: 16.sp,
                ),
                const CustomAdd(),

                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(
                    color: AppColor.gry,
                    thickness: 1.2,
                    height: 40,
                  ),
                ),
                  CustomSubTitle(
                  subtitle: "Hot?",
                  color: AppColor.white,
                  fontsize: 16.sp,
                ),
CustomHot(),
 // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(
                    color: AppColor.gry,
                    thickness: 1.2,
                    height: 20,
                  ),
                ),
                // SizedBox(height: 10,),
                const Counter(),
              ],
            ),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

void _showShareOptions(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColor.Dark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Share with",
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareIcon(
                    "assets/icons/whatsapp.svg",
                    "WhatsApp",
                    Colors.green,
                    () {
                      Navigator.pop(context);
                      // أضف هنا منطق المشاركة الفعلي لاحقًا
                    },
                  ),
                  _buildShareIcon(
                    "assets/icons/facebook.svg",
                    "Facebook",
                    Colors.blueAccent,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareIcon(
                    "assets/icons/instagram.svg",
                    "Instagram",
                    Colors.purple,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareIcon(
                    "assets/icons/telegram.svg",
                    "Telegram",
                    Colors.lightBlueAccent,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildShareIcon(
    String assetPath, String label, Color color, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.2),
          child: SvgPicture.asset(
            assetPath,
            width: 28,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: AppColor.white, fontSize: 10),
        ),
      ],
    ),
  );
}
