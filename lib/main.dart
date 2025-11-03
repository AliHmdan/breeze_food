import 'package:breezefood/blocs/language/language_cubit.dart';
import 'package:breezefood/blocs/language/language_state.dart';
import 'package:breezefood/presentation/screens/ads/page_ads.dart';
import 'package:breezefood/presentation/screens/pay_your_order.dart';
import 'package:breezefood/presentation/screens/profile/info_profile.dart';
import 'package:breezefood/presentation/screens/resturant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:breezefood/core/constans/routes.dart';

// Repositories
import 'package:breezefood/data/repositories/search_repository.dart';
import 'package:breezefood/data/repositories/profile_repository.dart';

// Cubits
import 'package:breezefood/blocs/search/search_cubit.dart';
import 'package:breezefood/blocs/auth/auth_cubit.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // (اختياري) مراقبة الـ Blocs للتصحيح
  Bloc.observer = SimpleBlocObserver();

  // ✅ LanguageCubit: يلتقط لغة الجهاز أول مرة ثم يحفظ/يستعيد اختيار المستخدم
  final langCubit = LanguageCubit();
  await langCubit.init();

  runApp(
    BlocProvider.value(
      value: langCubit,
      child: const MyApp(),
    ),
  );
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
            RepositoryProvider<SearchRepository>(create: (_) => SearchRepository()),
            RepositoryProvider<ProfileRepository>(create: (_) => ProfileRepository()),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
              BlocProvider<SearchCubit>(
                create: (ctx) {
                  final repo = ctx.read<SearchRepository>();
                  final cubit = SearchCubit(repo);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    cubit.loadSearchHistory();
                  });
                  return cubit;
                },
              ),
            ],
            child: BlocBuilder<LanguageCubit, LanguageState>(
              builder: (ctx, state) {
                final locale = state.locale; // Locale الحالي من الكيوبت
                final isArabic = locale.languageCode == 'ar';

                // تحكم عام بمقياس النص إن رغبت
                final media = MediaQuery.of(ctx);

                return MediaQuery(
                  data: media.copyWith(textScaleFactor: 1.2),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'breeze food',

                    // ✅ لغة التطبيق من الكيوبت
                    locale: locale,

                    // ✅ اتجاه الواجهة حسب اللغة الحالية
                    builder: (context, child) => Directionality(
                      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                      child: SafeArea(child: child ?? const SizedBox.shrink()),
                    ),

                    supportedLocales: const [Locale('en'), Locale('ar')],
                    localizationsDelegates: const [
                      // فعّل AppLocalizations.delegate إن كنت تستخدم gen-l10n
                      // AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],

                    // ملاحظة: هذا الكallback لن يطغى على locale القادم من الكيوبت،
                    // لكنه يستخدم عندما لا تُضبط locale يدويًا.
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      for (var l in supportedLocales) {
                        if (deviceLocale != null && deviceLocale.languageCode == l.languageCode) {
                          return deviceLocale;
                        }
                      }
                      return supportedLocales.first;
                    },

                    useInheritedMediaQuery: true,
                    initialRoute: AppRoute.splash_video_screen,
                    routes: {
                      AppRoute.splash_video_screen: (_) => const SplashVideoScreen(),
                   
                      AppRoute.successful: (_) => const Successful(),
                      AppRoute.phoneNumber: (_) => const PhoneNumber(),
                      AppRoute.information: (_) => const InformationScreen(),
                      AppRoute.login: (_) => const Login(),
                      AppRoute.mainShell: (_) => const MainShell(),
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
                      AppRoute.pay_your_order: (_) => const PayYourOrder(),
                      AppRoute.page_ads: (_) => const ReferralAdPage(),
                    },
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
