import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/button/custom_button.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:freeza_food/presentation/widgets/main_shell.dart';
import 'package:freeza_food/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrow(
                onTap: () {},
                color: AppColor.white,
                background: AppColor.black,
                colorborder: AppColor.LightActive,
              ),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Image.asset(
                            "assets/icons/Sticker.png",
                            height: 250.h,
                            width: 250.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTitle(title: "Successful", color: AppColor.white),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Thank you, your payment has been successful. You can now order and enjoy your favorite meal.",
                            style: TextStyle(
                              color: AppColor.gry,
                              fontSize: 14.sp,
                              fontFamily: "Manrope",
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          title: "Ok",
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const MainShell(initialIndex: 3),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
