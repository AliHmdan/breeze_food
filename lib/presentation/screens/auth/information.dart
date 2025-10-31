import 'package:freeza_food/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:freeza_food/presentation/widgets/button/custom_button.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:freeza_food/presentation/widgets/main_shell.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constans/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repositories/auth_repository.dart';
import '../update_address_screen.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;

  @override
  void initState() {
    super.initState();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
  }

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
                    hintText: "First Name",
                    controller: firstnameController,
                  ),

                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    hintText: "Last Name",
                    controller: lastnameController,
                  ),

                  /// التاريخ
                  // const CustomDatePickerField(),
                  SizedBox(height: 30.h),

                  /// الزر — حفظ المعلومات عبر API ثم الذهاب للرئيسية
                  CustomButton(
                    title: "Save",
                    onPressed: () async {
                      final first = firstnameController.text.trim();
                      final last = lastnameController.text.trim();
                      if (first.isEmpty || last.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter both first and last name',
                            ),
                          ),
                        );
                        return;
                      }

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      try {
                        final authRepo = AuthRepository();

                        // Ensure token header is present (AuthRepository bootstraps from SharedPreferences)
                        final resp = await authRepo.updateProfile(
                          firstName: first,
                          lastName: last,
                        );

                        Navigator.of(context).pop(); // remove loader

                        final success =
                            resp.statusCode != null &&
                            resp.statusCode! >= 200 &&
                            resp.statusCode! < 300;
                        if (success) {
                          // Persist first/last name locally
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('first_name', first);
                          await prefs.setString('last_name', last);

                          // Navigate to home (replace stack)
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => UpdateAddressScreen(),
                            ),
                          );
                        } else {
                          final message =
                              (resp.data is Map && resp.data['message'] != null)
                              ? resp.data['message'].toString()
                              : 'Failed to update profile';
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                      } catch (e) {
                        Navigator.of(context).pop(); // remove loader
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
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
