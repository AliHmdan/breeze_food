import 'package:breezefood/presentation/screens/profile/info_profile.dart';
import 'package:breezefood/presentation/screens/resturant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:breezefood/core/constans/routes.dart';

// Repositories
import 'package:breezefood/data/repositories/search_repository.dart';
import 'package:breezefood/data/repositories/profile_repository.dart';

// Cubits
import 'package:breezefood/blocs/search/search_cubit.dart';
import 'package:breezefood/blocs/auth/auth_cubit.dart'; // أنصح تضيف AuthCubit كمصدر حالة عالمي للمستخدم

// Screens
import 'package:breezefood/presentation/screens/splash_video_screen.dart';
import 'package:breezefood/presentation/screens/auth/signup.dart';
import 'package:breezefood/presentation/screens/successful.dart';
import 'package:breezefood/presentation/screens/auth/phone_number.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/auth/information.dart';
import 'package:breezefood/presentation/screens/auth/login.dart';
import 'package:breezefood/presentation/screens/search/search.dart';
import 'package:breezefood/presentation/screens/add_order/pay.dart';
import 'package:breezefood/presentation/screens/add_order/success.dart';
import 'package:breezefood/presentation/screens/profile/profile.dart';
import 'package:breezefood/presentation/screens/stores_nav_tab.dart';
import 'package:breezefood/presentation/screens/store_details/popular_grid_Page.dart';
import 'package:breezefood/presentation/screens/discount_grid_Page.dart';
import 'package:breezefood/presentation/screens/store_details/store_details.dart';
import 'package:breezefood/presentation/widgets/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // (اختياري) مراقبة الـ Blocs للتصحيح
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

/// مراقب اختياري لطباعة تغيّرات الحالات أثناء التطوير
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    assert(() {
      // ما يطبع إلا في Debug
      // ignore: avoid_print
      print('${bloc.runtimeType} -> $change');
      return true;
    }());
  }
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
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<SearchRepository>(
              create: (_) => SearchRepository(),
            ),
            RepositoryProvider<ProfileRepository>(
              create: (_) => ProfileRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              // مصدر حالة المستخدم للتطبيق كله
              BlocProvider<AuthCubit>(
                create: (_) => AuthCubit(),
              ),

              // SearchCubit عالمي (للبحث والسجل)
              BlocProvider<SearchCubit>(
                create: (ctx) {
                  final repo = ctx.read<SearchRepository>();
                  final cubit = SearchCubit(repo);
                  // نشغّل التحميل بعد فريم البناء الأول لضمان توافر الشجرة
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    cubit.loadSearchHistory();
                  });
                  return cubit;
                },
              ),
            ],
            child: Builder(
              builder: (ctx) {
                // طبّق تكبير النص على التطبيق كله
                final media = MediaQuery.of(ctx);
                return MediaQuery(
                  data: media.copyWith(textScaleFactor: 1.2),
                  child: SafeArea(
                    child: MaterialApp(
                      title: 'breeze food',
                      debugShowCheckedModeBanner: false,
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
                      AppRoute.mainShell: (_) => const MainShell(),
                        // AppRoute.home: (_) => const Home(),
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
                      
                          AppRoute.info_profile: (_) => const InfoProfile(),
                           AppRoute.orders: (_) => const Orders(),
                      },
                      // لو بدك onGenerateRoute لتزوّد Cubit خاص بمسار معيّن، استخدمه بدل routes الثابتة
                      // onGenerateRoute: (settings) { ... }
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
