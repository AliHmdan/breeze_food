import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final Color? labelColor;
  final TextEditingController? controller;
  final String hintText;
  final Color hintColor;
  final Color backgroundColor;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureInitially;

  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.hintText,
    this.hintColor = AppColor.LightActive,
    this.backgroundColor = const Color(0xFF2C2C2E),
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureInitially = true,
     this.label,  this.labelColor,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword ? widget.obscureInitially : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: TextStyle(color: AppColor.LightActive),
      decoration: InputDecoration(

        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColor.gry,
          fontSize: 14.sp,
          fontFamily: 'Manrope',
         
        ),
        filled: true,
        fillColor: AppColor.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                icon: Image.asset(
                  _obscure ? 'assets/icons/eye.png' : 'assets/icons/hide.png',
                  width: 24,
                  height: 24,
                  color: AppColor.black,
                ),
              )
            : null,
      ),
    );
  }
}
