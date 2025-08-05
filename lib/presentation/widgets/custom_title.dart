import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final Color color;

  const CustomTitle({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Manrope',
        color: color,
      ),
    );
  }
}
