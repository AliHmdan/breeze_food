import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/widgets/custom_arrow.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPassowrd extends StatelessWidget {
  const NewPassowrd({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children:<Widget> [
      Image.asset(
        "assets/images/background_auth.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrow(onTap: (){
                Navigator.of(context).pop();
              },background: AppColor.white,color: AppColor.Dark,),
              SizedBox(height: 25.h,),
              CustomTitle(title: " Enter your new password", color: AppColor.white),
              SizedBox(height: 25.h,),
              CustomTextFormField(
                hintText: "New Password",
                backgroundColor: AppColor.white,
                hintColor: AppColor.gry,
                isPassword: true,
                obscureInitially: true,
              ),
              SizedBox(height: 20.h,),
              CustomTextFormField(
                hintText: "Confirm New Password",
                backgroundColor: AppColor.white,
                hintColor: AppColor.gry,
                isPassword: true,
                obscureInitially: true,
              ),
              SizedBox(height: 30.h,),
              CustomButton(title: "Ok",onPressed: (){
                 Navigator.of(context).pushNamed(AppRoute.successful);
              },)
            ],
          ),
        ),
      ),
    ]
      
    );
  }
}
