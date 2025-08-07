import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/auth/verfiy_code.dart';
import 'package:breezefood/presentation/screens/spalsh_screen.dart';
import 'package:breezefood/presentation/screens/successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // حجم التصميم الخاص بك
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: ' breeze food',
          debugShowCheckedModeBanner: false,
          home: Successful(),
        );
      },
    );
  }
}
