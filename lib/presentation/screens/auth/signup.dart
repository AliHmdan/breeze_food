import 'package:breezefood/blocs/auth/sign_up/sign_up_state.dart';
import 'package:breezefood/blocs/auth/sign_up/sign_up_bloc.dart'; // يحوي SignupCubit
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController referralLinkController = TextEditingController();

  bool _navigated = false; // يمنع التنقّل المتكرر أثناء تغيّر الحالات

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralLinkController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final phone = phoneController.text.trim();
    final pass = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();
    final referral = referralLinkController.text.trim().isEmpty
        ? null
        : referralLinkController.text.trim();

    // تحققات سريعة
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أدخل رقم الهاتف')));
      return;
    }
    if (pass.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('كلمة المرور يجب ألا تقل عن 6 أحرف')));
      return;
    }
    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('كلمتا المرور غير متطابقتين')));
      return;
    }

    FocusScope.of(context).unfocus(); // اغلق الكيبورد لتقليل إعادة البناء
    context.read<SignupCubit>().signup(
          phone: phone,
          password: pass,
          confirmPassword: confirm,
          referralCode: referral,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(AuthRepository()),
      child: BlocListener<SignupCubit, SignupState>(
        listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
        listener: (context, state) {
          if (state is SignupSuccess && !_navigated) {
            _navigated = true;
            // نفّذ بعد الإطار الحالي لتجنّب التنقّل أثناء البناء
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              final data = state.data;
              final sentCode = (data is Map) ? data['code'] : null;

              Navigator.of(context).pushReplacementNamed(
                AppRoute.verifyCode,
                arguments: {
                  'phone': phoneController.text.trim(),
                  'code': sentCode, // اختياري
                },
              );
            });
          } else if (state is SignupFailure) {
            _navigated = false;
            final msg = state.message.isNotEmpty ? state.message : 'حدث خطأ، حاول لاحقًا';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
          }
        },

        child: Builder(
          builder: (context) {
            // حالة التحميل (تعطيل اللمس + إظهار لودينغ مركزي)
            final isLoading = context.select<SignupCubit, bool>(
              (c) => c.state is SignupLoading,
            );

            return WillPopScope(
              onWillPop: () async => !isLoading, // لا ترجع للخلف أثناء التحميل
              child: Stack(
                children: [
                  // === UI الأساسي كما هو (نفس الستايل) ===
                  Scaffold(
                    backgroundColor: AppColor.primaryColor,
                    body: Stack(
                      children: [
                        // Banner
                        Image.asset(
                          "assets/images/top-view-burgers-with-cherry-tomatoes.png",
                          width: double.infinity,
                          height: 265.h,
                          fit: BoxFit.cover,
                          cacheWidth: 1080, // لتقليل الذاكرة
                        ),
                        // Logo
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 80.h),
                            child: Image.asset(
                              "assets/images/breeze-food2.png",
                              width: 150.w,
                            ),
                          ),
                        ),
                        // Form Container
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 228.h,
                          bottom: 0,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.Dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.r),
                                topRight: Radius.circular(24.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTitle(title: "Welcome to breeze", color: AppColor.white),
                                          SizedBox(height: 8.h),
                                          CustomSubTitle(
                                            subtitle: "Please Enter your phone to signup",
                                            color: AppColor.gry,
                                            fontsize: 14.sp,
                                          ),
                                          SizedBox(height: 32.h),

                                          // Phone
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                                                decoration: BoxDecoration(
                                                  color: AppColor.white,
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  border: Border.all(color: AppColor.gry),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/syria.png',
                                                      width: 24.w,
                                                      height: 24.h,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      '+963',
                                                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: CustomTextFormField(
                                                  controller: phoneController,
                                                  hintText: "Phone Number",
                                                  keyboardType: TextInputType.number,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.h),

                                          // Password
                                          CustomTextFormField(
                                            controller: passwordController,
                                            hintText: "Password",
                                            isPassword: true,
                                            obscureInitially: true,
                                          ),
                                          SizedBox(height: 16.h),

                                          // Confirm Password
                                          CustomTextFormField(
                                            controller: confirmPasswordController,
                                            hintText: "Confirm Password",
                                            isPassword: true,
                                            obscureInitially: true,
                                          ),
                                          SizedBox(height: 16.h),

                                          // Referral (optional)
                                          CustomTextFormField(
                                            controller: referralLinkController,
                                            hintText: "Referral code (optional)",
                                          ),
                                          SizedBox(height: 30.h),

                                          // زر Continue (بدون تنقّل هنا)
                                          CustomButton(
                                            title: "Continue",
                                            onPressed: isLoading ? null : () => _submit(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Already have an account?
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: Center(
                                      child: Text.rich(
                                        TextSpan(
                                          text: "Already have an account? ",
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 14.sp,
                                            fontFamily: "Manrope",
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "Login Now",
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                fontFamily: "Manrope",
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  if (!isLoading) {
                                                    Navigator.of(context).pushNamed(AppRoute.login);
                                                  }
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // === Overlay اللودينغ (يغطي الصفحة كلها) ===
                  if (isLoading) ...[
                    const ModalBarrier(dismissible: false, color: Colors.black54),
                    const Center(child: CircularProgressIndicator()),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
