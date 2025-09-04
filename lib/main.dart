import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/screens/add_order/add_order.dart';
import 'package:breezefood/presentation/screens/add_order/request_order.dart';
import 'package:breezefood/presentation/screens/auth/information.dart';
import 'package:breezefood/presentation/screens/auth/login.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/auth/phone_number.dart';
import 'package:breezefood/presentation/screens/auth/signup.dart';
import 'package:breezefood/presentation/screens/auth/verfiy_code.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
import 'package:breezefood/presentation/screens/orders.dart';
import 'package:breezefood/presentation/screens/search.dart';
import 'package:breezefood/presentation/screens/store_details/stroe_details.dart';
import 'package:breezefood/presentation/screens/spalsh_screen.dart';
import 'package:breezefood/presentation/screens/successful.dart';
import 'package:breezefood/presentation/screens/stores.dart';
import 'package:breezefood/presentation/widgets/auth/custom_date_picker_screen.dart';
import 'package:breezefood/presentation/screens/discount_grid_Page.dart';
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
          home: RequestOrder()
          // StroeDetails( categories: ["Burger", "Chrispy", "India food", "Home"])
          // DetailsCategoris(),
          // initialRoute: AppRoute.spalshscreen,
      //     routes: {
      //       AppRoute.login: (context) =>  Login(),
      //     //   // AppRoute.signUp: (context) => const Signup(),
      //       AppRoute.verfiy_code:(context)=>const VerfiyCode(),
      //     //   // AppRoute.successful:(context)=>const Successful(),
      //     //   // AppRoute.phonenumber:(context)=>const PhoneNumber(),
      //     //   // AppRoute.new_passowrd:(context)=>const NewPassowrd(),
      //     //   // AppRoute.information:(context)=>const InformationScreen(),
      //     },
        );
      //
      },
    );
  }
}
