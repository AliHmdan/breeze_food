import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/screens/add_order/pay.dart';
import 'package:freeza_food/presentation/screens/add_order/success.dart';
import 'package:freeza_food/presentation/screens/auth/information.dart';
import 'package:freeza_food/presentation/screens/auth/login.dart';
import 'package:freeza_food/presentation/screens/auth/new_passowrd.dart';
import 'package:freeza_food/presentation/screens/auth/phone_number.dart';
import 'package:freeza_food/presentation/screens/auth/signup.dart';
import 'package:freeza_food/presentation/screens/auth/verfiy_code.dart';
import 'package:freeza_food/presentation/screens/discount_grid_Page.dart';
import 'package:freeza_food/presentation/screens/home/home.dart';
import 'package:freeza_food/presentation/screens/profile/profile.dart';
import 'package:freeza_food/presentation/screens/search.dart';
import 'package:freeza_food/presentation/screens/spalsh_screen.dart';
import 'package:freeza_food/presentation/screens/store_details/popular_grid_Page.dart';
import 'package:freeza_food/presentation/screens/store_details/store_details.dart';
import 'package:freeza_food/presentation/screens/stores_nav_tab.dart';
import 'package:freeza_food/presentation/screens/successful.dart';
import 'package:freeza_food/presentation/widgets/main_shell.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/search/search_cubit.dart';
import 'package:freeza_food/data/repositories/search_repository.dart';
import 'package:freeza_food/data/repositories/home_repository.dart';
import 'package:freeza_food/blocs/home/home_cubit.dart';
import 'package:freeza_food/presentation/screens/update_address_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SearchCubit>(
              create: (_) =>
                  SearchCubit(SearchRepository())..loadSearchHistory(),
            ),
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(HomeRepository())..loadHome(),
            ),
          ],
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
            child: MaterialApp(
              title: 'breeze food',
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoute.UpdateAddressScreen,
              routes: {
                AppRoute.splashScreen: (context) => const SpalshScreen(),
                AppRoute.signUp: (context) => Signup(),
                AppRoute.verifyCode: (context) {
                  final phone =
                      ModalRoute.of(context)!.settings.arguments as String;
                  return VerfiyCode(phone: phone);
                },
                AppRoute.successful: (context) => Successful(),
                AppRoute.phoneNumber: (context) => PhoneNumber(),
                AppRoute.newPassword: (context) => NewPassowrd(),
                AppRoute.information: (context) => InformationScreen(),
                AppRoute.login: (context) => Login(),
                // When navigating to AppRoute.home we first show an update-address screen
                // which will call the address update API and then open the real Home.
                AppRoute.UpdateAddressScreen: (context) => const UpdateAddressScreen(),
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
          ),
        );
      },
    );
  }
}
