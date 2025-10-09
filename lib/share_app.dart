
import 'package:freeza_food/presentation/widgets/share_dialoh.dart';
import 'package:freeza_food/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/core/constans/color.dart';
import 'package:qr_flutter/qr_flutter.dart';

// استدعاء دالة الـ Dialog (انسخها من الملف السابق أو ضعها بملف خارجي)

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String appLink = "https://your-link.com"; // رابط التطبيق

    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomAppbarProfile(
            title: "Profile",
            icon: Icons.arrow_back_ios,
            ontap: () => Navigator.pop(context),
            // icon: Icons.group,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 0.85.sw,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 10.r,
                  offset: Offset(0, 5.h),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSubTitle(
                  subtitle: "Scan for Download App",
                  color: AppColor.white,
                  fontsize: 18.sp,
                ),
                SizedBox(height: 20.h),

                // QR مع GestureDetector لفتح Dialog
                GestureDetector(
                  onTap: () {
                    showShareDialog(context, appLink);
                  },
                  child: Container(
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: QrImageView(
                      data: appLink,
                      version: QrVersions.auto,
                      size: 0.5.sw,
                      backgroundColor: AppColor.white,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  "Scan the QR code to visit link and\n download application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 12.sp,
                    fontFamily: "Monrope",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
