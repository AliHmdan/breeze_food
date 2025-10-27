import 'package:breezefood/blocs/auth/verfiy_code/verfiy_code_cubit.dart';
import 'package:breezefood/blocs/auth/verfiy_code/verfiy_code_state.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';
import 'package:breezefood/presentation/widgets/custom_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constans/color.dart';
import '../../widgets/title/custom_sub_title.dart';
import '../../widgets/title/custom_title.dart';

class VerfiyCode extends StatelessWidget {
  final String? phone;        // لم يعد required
  final String? initialCode;  // كود تمهيدي اختياري (إن أتى من API)
  const VerfiyCode({super.key, this.phone, this.initialCode});

  @override
  Widget build(BuildContext context) {
    // 📦 التماس الـ arguments لو ما وصل phone/ code للكونستركتر
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String effectivePhone =
        phone ?? (args?['phone']?.toString() ?? '');
    final String? effectiveInitCode =
        initialCode ?? args?['code']?.toString();

    return BlocProvider(
      create: (_) => VerifyCodeCubit(AuthRepository()),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            Navigator.of(context).pushReplacementNamed(AppRoute.information);
          } else if (state is ResendCodeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ تم إعادة إرسال الكود")),
            );
          } else if (state is VerifyCodeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<VerifyCodeCubit>();

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Image.asset(
                  "assets/images/background_auth.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomArrow(
                        onTap: () => Navigator.of(context).pop(),
                        color: AppColor.Dark,
                        background: AppColor.white,
                      ),
                      SizedBox(height: 10.h),
                      CustomTitle(title: "Enter the Code", color: AppColor.white),
                      SizedBox(height: 8.h),
                      CustomSubTitle(
                        // 📞 اعرض الهاتف الفعّال (مع كود الدولة الذي تريد)
                        subtitle: effectivePhone.isNotEmpty
                            ? "Enter the verification code we just sent to +963$effectivePhone"
                            : "Enter the verification code we just sent to your phone",
                        color: AppColor.gry,
                        fontsize: 14.sp,
                      ),
                      SizedBox(height: 45.h),

                      // 🔢 حقل الكود
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: PinCodeTextField(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          appContext: context,
                          length: 4,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 70,
                            fieldWidth: 70,
                            activeColor: AppColor.primaryColor,
                            selectedColor: AppColor.primaryColor,
                            inactiveColor: AppColor.gry,
                            activeBorderWidth: 4,
                            selectedBorderWidth: 4,
                            inactiveBorderWidth: 4,
                            activeFillColor: AppColor.white,
                            selectedFillColor: AppColor.white,
                            inactiveFillColor: AppColor.gry,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          // لو بدك تملأ الكود تلقائيًا لو وصلك initialCode من السيرفر، استخدم controller
                          onCompleted: (v) {
                            if (effectivePhone.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('رقم الهاتف غير متوفر')),
                              );
                              return;
                            }
                            cubit.verifyCode(
                              phone: effectivePhone, // ✅ مطلوب بالاسم وبنوع String
                              code: v,
                            );
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(height: 20),

                      // 🔁 إعادة إرسال
                      InkWell(
                        onTap: state is ResendCodeLoading
                            ? null
                            : () {
                                if (effectivePhone.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('رقم الهاتف غير متوفر')),
                                  );
                                  return;
                                }
                                cubit.resendCode(
                                  phone: effectivePhone, // ✅ مُعامل مُسمّى (required)
                                );
                              },
                        child: CustomSubTitle(
                          subtitle: state is ResendCodeLoading ? "Sending..." : "Resend Code",
                          color: AppColor.primaryColor,
                          fontsize: 12.sp,
                        ),
                      ),

                      // (اختياري) عرض الكود المُرسل تلقائياً إن أحببت
                      if (effectiveInitCode != null) ...[
                        SizedBox(height: 12.h),
                        Text(
                          "Code: $effectiveInitCode",
                          style: TextStyle(color: AppColor.gry, fontSize: 12.sp),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}