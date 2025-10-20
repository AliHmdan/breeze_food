import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/screens/add_order/pay.dart';
import 'package:freeza_food/presentation/screens/add_order/request_order.dart';
import 'package:freeza_food/presentation/screens/add_order/success.dart';

import 'package:freeza_food/presentation/screens/auth/information.dart';
import 'package:freeza_food/presentation/screens/auth/login.dart';
import 'package:freeza_food/presentation/screens/auth/new_passowrd.dart';
import 'package:freeza_food/presentation/screens/auth/phone_number.dart';
import 'package:freeza_food/presentation/screens/auth/signup.dart';
import 'package:freeza_food/presentation/screens/auth/verfiy_code.dart';
import 'package:freeza_food/presentation/screens/home/home.dart';
import 'package:freeza_food/presentation/screens/profile/profile.dart';
import 'package:freeza_food/presentation/screens/search.dart';
import 'package:freeza_food/presentation/screens/spalsh_screen.dart';
import 'package:freeza_food/presentation/screens/store_details/stroe_details.dart';
import 'package:freeza_food/presentation/screens/stores.dart';
import 'package:freeza_food/presentation/screens/successful.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
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
            // home:Home()
            // Stores()
            // StoreDetails( categories: ["Burger", "Chrispy", "India food", "Home"])
            // DetailsCategoris(),
            initialRoute: AppRoute.splashScreen,
            routes: {
              AppRoute.splashScreen: (context) => const SpalshScreen(),
              AppRoute.signUp: (context) => Signup(),
              AppRoute.verifyCode: (context) {
                final phone = ModalRoute.of(context)!.settings.arguments as String;
                return VerfiyCode(phone: phone);
              },
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
              AppRoute.stores_nav_tab: (context) => Stores(),
              AppRoute.StoreDetails: (context) => StoreDetails(
                categories: ["Burger", "Chrispy", "India food", "Home"],
             
              ),
            },
          ),
        );
        //
      },
    );
  }
}
