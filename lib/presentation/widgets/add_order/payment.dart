import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodSelector extends StatefulWidget {
  @override
  _PaymentMethodSelectorState createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State {
  String _selectedMethod = "visa"; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPaymentOption(
          value: "visa",

          groupValue: _selectedMethod,

          title: "Visa card",

          image: "assets/images/visa.png",
        ),

        _buildPaymentOption(
          value: "master",

          groupValue: _selectedMethod,

          title: "Master card",

          image: "assets/images/master.png",
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String value,

    required String groupValue,

    required String title,

    required String image,
  }) {
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),

      color: AppColor.black, // الخلفية الغامقة

      child: RadioListTile(
        value: value,

        groupValue: groupValue,

        onChanged: (val) {
          setState(() {
            _selectedMethod = val!;
          });
        },

        activeColor: AppColor.primaryColor,

        title: CustomSubTitle(
          subtitle: title,
          color: AppColor.light,
          fontsize: 14.sp,
        ),

        secondary: Image.asset(
          image,

          height: 40.h,

          width: 60.w,

          fit: BoxFit.contain,
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      ),
    );
  }
}
