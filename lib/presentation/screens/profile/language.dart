import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String _selectedLanguage = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomAppbarProfile(
            title: "Language",
            icon: Icons.arrow_back_ios,
            ontap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // زر الإنجليزية
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLanguage = "en";
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: _selectedLanguage == "en"
                        ? Colors.cyanAccent // اللون التركوازي للزر الفعّال
                        : Colors.grey[800], // اللون الغامق للزر الغير مفعل
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "English",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // زر العربية
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLanguage = "ar";
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: _selectedLanguage == "ar"
                        ? Colors.cyanAccent
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Arabic",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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