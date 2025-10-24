import 'package:breezefood/blocs/search/search_cubit.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/repositories/search_repository.dart';

import 'package:breezefood/presentation/screens/add_order/pay.dart';
import 'package:breezefood/presentation/screens/add_order/success.dart';
import 'package:breezefood/presentation/screens/auth/information.dart';
import 'package:breezefood/presentation/screens/auth/login.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/auth/phone_number.dart';
import 'package:breezefood/presentation/screens/auth/signup.dart';
import 'package:breezefood/presentation/screens/discount_grid_Page.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
import 'package:breezefood/presentation/screens/profile/profile.dart';
import 'package:breezefood/presentation/screens/search/search.dart'; // شاشة اسمها Search
import 'package:breezefood/presentation/screens/splash_video_screen.dart';
import 'package:breezefood/presentation/screens/store_details/popular_grid_Page.dart';
import 'package:breezefood/presentation/screens/store_details/store_details.dart';
import 'package:breezefood/presentation/screens/stores_nav_tab.dart';
import 'package:breezefood/presentation/screens/successful.dart';
import 'package:breezefood/presentation/widgets/main_shell.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
              create: (_) => SearchCubit(SearchRepository())..loadSearchHistory(),
            ),
          ],
          child: Builder(
            // Builder حتى نأخذ MediaQuery من نفس الشجرة
            builder: (ctx) {
              final media = MediaQuery.of(ctx);
              return MediaQuery(
                data: media.copyWith(textScaleFactor: 1.2),
                child: MaterialApp(
                  title: 'breeze food',
                  debugShowCheckedModeBanner: false,
                  // يورّث باقي خصائص الـ MediaQuery
                  useInheritedMediaQuery: true,

                  initialRoute: AppRoute.splash_video_screen,

                  routes: {
                    AppRoute.splash_video_screen: (_) => const SplashVideoScreen(),
                    AppRoute.signUp: (_) => const Signup(),
                    AppRoute.successful: (_) => const Successful(),
                    AppRoute.phoneNumber: (_) => const PhoneNumber(),
                    AppRoute.newPassword: (_) => const NewPassowrd(),
                    AppRoute.information: (_) => const InformationScreen(),
                    AppRoute.login: (_) => const Login(),

                    AppRoute.home: (_) => const Home(),
                    // اسم الشاشة Search حسب ملفك
                    AppRoute.search: (_) => const Search(),

                    AppRoute.pay: (_) => const Pay(),
                    AppRoute.success: (_) => const Success(),

                    AppRoute.profile: (_) => const Profile(),
                    AppRoute.stores_nav_tab: (_) => const StoresNavTab(),
                    AppRoute.PopularGridPage: (_) => const PopularGridPage(),
                    AppRoute.discountDetails: (_) => const DiscountGridPage(),

                    AppRoute.StoreDetails: (_) => const StoreDetails(
                      categories: ["Burger", "Chrispy", "India food", "Home"],
                    ),
                    AppRoute.mainShell: (_) => const MainShell(),
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
