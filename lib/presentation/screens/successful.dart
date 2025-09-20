import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // خلفية الشاشة
        Image.asset(
          "assets/images/background_auth.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),

        // المحتوى فوق الخلفية
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const Spacer(),

                    // ✅ الصورة داخل Center وبأبعاد مناسبة لكل الشاشات
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Image.asset(
                        "assets/icons/Sticker.png",
                        height: 250.h,
                        width: 250.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    CustomTitle(title: "Successful", color: AppColor.white),
                    SizedBox(height: 10.h),
                    CustomSubTitle(
                      subtitle: "Passward Has been changed successifully",
                      color: AppColor.gry,
                      fontsize: 14.sp,
                    ),
                    SizedBox(height: 20.h,),
                    CustomButton(title: "Ok",onPressed: (){
                                       Navigator.of(context).pushReplacementNamed(AppRoute.login);

                    },),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
