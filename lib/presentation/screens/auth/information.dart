import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:freeza_food/presentation/widgets/button/custom_button.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constans/color.dart';
import '../../widgets/auth/custom_date_picker_screen.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// ✅ الخلفية مرنة مع الشاشة
            Image.asset(
            "assets/images/background_auth.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
         

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// السهم
                  CustomArrow(
                    onTap: () => Navigator.of(context).pop(),
                    color: AppColor.Dark,
                    background: AppColor.white,
                  ),

                  SizedBox(height: 16.h),

               
                  CustomSubTitle(
                    subtitle: "Please enter your information",
                    color: AppColor.white,
                    fontsize: 14.sp,
                  ),

                  SizedBox(height: 35.h),

                  /// الاسم
                  CustomTextFormField(
                    hintText: "Full Name",
                    backgroundColor: AppColor.white,
                    hintColor: AppColor.gry,
                  ),

                  SizedBox(height: 20.h),

                  /// التاريخ
                  const CustomDatePickerField(),

                  SizedBox(height: 30.h),

                  /// الزر
                  CustomButton(
                    title: "Login",
                    onPressed: () {
              
                      Navigator.of(context).pushReplacementNamed(AppRoute.UpdateAddressScreen);
                    },
                  ),

                  SizedBox(height: 40.h), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
