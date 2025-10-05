import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends StatefulWidget {
  const CustomDatePickerField({Key? key}) : super(key: key);

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  final TextEditingController _dateController = TextEditingController();

  // final Color primaryColor = const Color(0xFF00D4D4);
  // final Color surfaceColor = const Color(0xFF1C1C1E);
  // final Color onSurfaceColor = Colors.white;

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: Colors.white,
              surface: AppColor.white,
              onSurface: AppColor.Dark,
            ),
            dialogBackgroundColor: AppColor.primaryColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.white,
                backgroundColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              todayForegroundColor: MaterialStateProperty.all(
                AppColor.primaryColor,
              ),
              todayBackgroundColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: UnconstrainedBox( // 👇 هذا لتقليص عرض الـ DatePicker
              child: Center(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                 maxWidth: 350.w,
                      maxHeight: 600.h,// 👈 التحكم في عرض الـ DatePicker
                    ),
                  child: child!,
                ),
              ),
            ),
          ),
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: _dateController,
      readOnly: true,
      style: const TextStyle(color: AppColor.LightActive),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.white,
        hintText: 'Birthday',
        hintStyle: TextStyle(
          color: AppColor.gry,
          fontSize: 14.sp,
          fontFamily: "Manrope",
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/date.svg',
            height: 20,
            width: 20,
            color: AppColor.Dark, // يمكنك تخصيص اللون حسب الحاجة
          ),
          onPressed: () => _selectDate(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),

      ),
      onTap: () {
        _selectDate(context);
      },
    );
  }
}
