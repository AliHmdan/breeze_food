import 'dart:io';
import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/button/custom_button.dart';
import 'package:freeza_food/presentation/widgets/profile/custom_textfaild_info.dart';
import 'package:freeza_food/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class InfoProfile extends StatefulWidget {
  const InfoProfile({super.key});

  @override
  State<InfoProfile> createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showPickOptionsDialog() {
    showModalBottomSheet(
      backgroundColor: AppColor.primaryColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.r),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_camera, color: AppColor.white, size: 22.sp),
              title: CustomSubTitle(
                subtitle: "التقاط صورة",
                color: AppColor.white,
                fontsize: 14.sp,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColor.white, size: 22.sp),
              title: CustomSubTitle(
                subtitle: "اختيار من المعرض",
                color: AppColor.white,
                fontsize: 14.sp,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // صورة البروفايل مع أيقونة التعديل
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70.r,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : const AssetImage("assets/images/person.jpg"),
                  ),
                  GestureDetector(
                    onTap: _showPickOptionsDialog,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColor.Dark,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.LightActive,
                          width: 1.w,
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 18.w,
                        height: 18.h,
                        colorFilter: const ColorFilter.mode(
                          AppColor.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.h),

              // حقل الاسم
              CustomTextfaildInfo(
                keyboardType: TextInputType.text,
                hint: "Ibrahim Ahmad",
                label: "Full Name",
              ),
              SizedBox(height: 15.h),

              // حقل الايميل
              CustomTextfaildInfo(
                keyboardType: TextInputType.emailAddress,
                hint: "ibrahim@gmail.com",
                label: "Email",
              ),
              SizedBox(height: 15.h),

              // حقل رقم الهاتف
              CustomTextfaildInfo(
                keyboardType: TextInputType.number,
                hint: "0938204147",
                label: "Phone Number",
              ),
              SizedBox(height: 30.h),

              // زر الحفظ
              CustomButton(title: "Save", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
