import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/screens/add_order/pay.dart';
import 'package:breezefood/presentation/screens/add_order/success.dart';
import 'package:breezefood/presentation/screens/auth/information.dart';
import 'package:breezefood/presentation/screens/auth/login.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/auth/phone_number.dart';
import 'package:breezefood/presentation/screens/auth/signup.dart';
import 'package:breezefood/presentation/screens/auth/verfiy_code.dart';
import 'package:breezefood/presentation/screens/discount_grid_Page.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
import 'package:breezefood/presentation/screens/profile/profile.dart';
import 'package:breezefood/presentation/screens/search/search.dart';
import 'package:breezefood/presentation/screens/spalsh_screen.dart';
import 'package:breezefood/presentation/screens/store_details/popular_grid_Page.dart';
import 'package:breezefood/presentation/screens/store_details/store_details.dart';
import 'package:breezefood/presentation/screens/stores_nav_tab.dart';
import 'package:breezefood/presentation/screens/successful.dart';
import 'package:breezefood/presentation/widgets/main_shell.dart';

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
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
          child: MaterialApp(
            title: ' breeze food',
            debugShowCheckedModeBanner: false,
            // home:StoresNavTab()
            // Stores()
            // StoreDetails( categories: ["Burger", "Chrispy", "India food", "Home"])
            // DetailsCategoris(),
            initialRoute: AppRoute.splashScreen,
            routes: {
              AppRoute.splashScreen: (context) => const SpalshScreen(),
              AppRoute.signUp: (context) => Signup(),
             AppRoute.verifyCode: (context) => const VerfiyCode(),
              AppRoute.successful: (context) => Successful(),
              AppRoute.phoneNumber: (context) => PhoneNumber(),
              AppRoute.newPassword: (context) => NewPassowrd(),
              AppRoute.information: (context) => InformationScreen(),
              AppRoute.login: (context) => Login(),
              AppRoute.home: (context) => Home(),
              AppRoute.search: (context) => Search(),
              AppRoute.pay: (context) => Pay(),
              AppRoute.Success: (context) => Success(),
              AppRoute.profile: (context) => Profile(),
              AppRoute.stores_nav_tab: (context) => StoresNavTab(),
              AppRoute.PopularGridPage: (context) => PopularGridPage(),
              AppRoute.discountDetails: (context) => DiscountGridPage(),

              AppRoute.StoreDetails: (context) => StoreDetails(
                categories: ["Burger", "Chrispy", "India food", "Home"],
              ),
              AppRoute.mainShell: (context) => MainShell(),
            },
          ),
        );
        //
      },
    );
  }
}
