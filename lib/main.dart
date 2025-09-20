import 'package:breezefood/core/constans/routes.dart';

import 'package:breezefood/presentation/screens/auth/information.dart';
import 'package:breezefood/presentation/screens/auth/login.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/auth/phone_number.dart';
import 'package:breezefood/presentation/screens/auth/signup.dart';
import 'package:breezefood/presentation/screens/auth/verfiy_code.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
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
      designSize: const Size(375, 812), // حجم التصميم الخاص بك
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: ' breeze food',
          debugShowCheckedModeBanner: false,
          // home: Signup()
          // StroeDetails( categories: ["Burger", "Chrispy", "India food", "Home"])
          // DetailsCategoris(),
          initialRoute: AppRoute.splashScreen,
          routes: {
            AppRoute.splashScreen: (context) => const SpalshScreen(), 
            AppRoute.login: (context) =>  Login(),
            AppRoute.signUp: (context) =>  Signup(),
            AppRoute.verifyCode:(context)=> VerfiyCode(),
            AppRoute.successful:(context)=> Successful(),
            AppRoute.phoneNumber:(context)=> PhoneNumber(),
            AppRoute.newPassword:(context)=> NewPassowrd(),
            AppRoute.information:(context)=> InformationScreen(),
              AppRoute.home:(context)=> Home(),
          },
        );
      //
      },
    );
  }
}
