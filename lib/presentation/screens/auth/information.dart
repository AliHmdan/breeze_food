import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../core/constans/color.dart';
import '../../widgets/auth/custom_date_picker_screen.dart';
import '../../widgets/auth/data_picker.dart'; // اسم الملف الجديد

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Please enter your information",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomTextFormField(
                hintText: "Full Name",
                backgroundColor: AppColor.white,
                hintColor: AppColor.gry,
              ),
              SizedBox(height: 20),
              // ✅ استدعاء ويدجت التاريخ الجديدة
              CustomDatePickerField(),

              // ✅ حقل اسم المستخدم

              // تابع إضافة المزيد من الحقول هنا حسب الحاجة
            ],
          ),
        ),
      ),
    );
  }
}
