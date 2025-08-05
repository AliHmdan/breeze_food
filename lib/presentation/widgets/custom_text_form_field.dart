import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
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
    this.hintColor = Colors.white70,
    this.backgroundColor = const Color(0xFF2C2C2E),
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureInitially = true,
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
          color: widget.hintColor,
          fontSize: 14.sp,
          fontFamily: 'Manrope',
          // fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: widget.backgroundColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
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
                  _obscure
                      ? 'assets/icons/eye.png' // صورة "إظهار"
                      : 'assets/icons/eye.png', // صورة "إخفاء"
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
