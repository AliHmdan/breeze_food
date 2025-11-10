import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/presentation/screens/orders.dart';
import 'package:geolocator/geolocator.dart';

// Routes constants
import 'package:freeza_food/core/constans/routes.dart';

// Repositories
import 'package:freeza_food/data/repositories/search_repository.dart';
import 'package:freeza_food/data/repositories/profile_repository.dart';

// Cubits
import 'package:freeza_food/blocs/search/search_cubit.dart';
import 'package:freeza_food/blocs/auth/auth_cubit.dart';

// Screens
import 'package:freeza_food/presentation/screens/splash_video_screen.dart';
import 'package:freeza_food/presentation/screens/auth/signup.dart';
import 'package:freeza_food/presentation/screens/successful.dart';
import 'package:freeza_food/presentation/screens/auth/phone_number.dart';
import 'package:freeza_food/presentation/screens/auth/new_passowrd.dart';
import 'package:freeza_food/presentation/screens/auth/information.dart';
import 'package:freeza_food/presentation/screens/auth/login.dart';
import 'package:freeza_food/presentation/screens/search/search.dart';
import 'package:freeza_food/presentation/screens/update_address_screen.dart';
import 'package:freeza_food/presentation/screens/add_order/pay.dart';
import 'package:freeza_food/presentation/screens/add_order/success.dart';
import 'package:freeza_food/presentation/screens/profile/profile.dart';
import 'package:freeza_food/presentation/screens/stores_nav_tab.dart';
import 'package:freeza_food/presentation/screens/store_details/popular_grid_Page.dart';
import 'package:freeza_food/presentation/screens/discount_grid_Page.dart';
import 'package:freeza_food/presentation/screens/profile/info_profile.dart';
import 'package:freeza_food/presentation/screens/pay_your_order.dart';
import 'package:freeza_food/presentation/screens/ads/page_ads.dart';
import 'package:freeza_food/presentation/widgets/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // مبدئيًا فقط تأكد من توفر الخدمات (اختياري)
  // لا تطلب صلاحيات أو Streams هنا لتجنّب حظر الـ UI Thread
  await Geolocator.isLocationServiceEnabled();

  // مراقب تغيّرات الـ BLoC (Debug فقط)
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

/// مراقب اختياري لطباعة تغيّرات الحالات أثناء التطوير
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    assert(() {
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
              BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
              BlocProvider<SearchCubit>(
                create: (ctx) {
                  final repo = ctx.read<SearchRepository>();
                  final cubit = SearchCubit(repo);
                  // شغّل أي تحميل بعد أول فريم
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    cubit.loadSearchHistory();
                  });
                  return cubit;
                },
              ),
            ],
            child: Builder(
              builder: (ctx) {
                final media = MediaQuery.of(ctx);
                return MaterialApp(
                  title: 'breeze food',
                  debugShowCheckedModeBanner: false,
                  useInheritedMediaQuery: true,
                  // إن كنت تريد بداية من Splash فعلاً، تأكد أن المفتاح موجود بالـ routes:
                  initialRoute: AppRoute.splash_video_screen,
                  // بديل آمن: استخدم home بدل initialRoute (اختر واحد فقط)
                  // home: const SplashVideoScreen(),

                  routes: {
                    // ✅ تأكدنا من وجود الراوت الخاص بالـ initialRoute
                    AppRoute.splash_video_screen: (_) => const SplashVideoScreen(),

                    AppRoute.home: (_) => const UpdateAddressScreen(),
                    AppRoute.signUp: (_) => Signup(),
                    AppRoute.successful: (_) => const Successful(),
                    AppRoute.phoneNumber: (_) => const PhoneNumber(),
                    AppRoute.newPassword: (_) => const NewPassowrd(),
                    AppRoute.information: (_) => const InformationScreen(),
                    AppRoute.login: (_) => Login(),
                    AppRoute.mainShell: (_) => const MainShell(),

                    AppRoute.search: (_) => const Search(),

                    AppRoute.pay: (_) => const Pay(),
                    AppRoute.success: (_) => const Success(),

                    AppRoute.profile: (_) => const Profile(),
                    AppRoute.stores_nav_tab: (_) => const StoresNavTab(),
                    AppRoute.PopularGridPage: (_) => PopularGridPage(),
                    AppRoute.discountDetails: (_) => const DiscountGridPage(),

                    AppRoute.info_profile: (_) => const InfoProfile(),
                    AppRoute.orders: (_) => const Orders(),
                    AppRoute.pay_your_order: (_) => const PayYourOrder(),
                    AppRoute.page_ads: (_) => const ReferralAdPage(),
                  },

                  // امسك أي مسار غير معرّف برسالة/صفحة لطيفة بدل انهيار صامت
                  onUnknownRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => const _RouteNotFoundPage(),
                    );
                  },

                  // لو تحب تثبيت عامل تكبير النص للتطبيق كله
                  builder: (context, child) {
                    return MediaQuery(
                      data: media.copyWith(textScaleFactor: 1.2),
                      child: child ?? const SizedBox.shrink(),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// صفحة بسيطة لمسارات غير معرّفة
class _RouteNotFoundPage extends StatelessWidget {
  const _RouteNotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'الصفحة غير موجودة',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
