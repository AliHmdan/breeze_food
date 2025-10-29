import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../blocs/auth/verfiy_code/verfiy_code_cubit.dart';
import '../../../blocs/auth/verfiy_code/verfiy_code_state.dart';
import '../../../core/constans/color.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../widgets/title/custom_sub_title.dart';
import '../../widgets/title/custom_title.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class VerfiyCode extends StatefulWidget {
  final String phone;

  const VerfiyCode({super.key, required this.phone});

  @override
  State<VerfiyCode> createState() => _VerfiyCodeState();
}

class _VerfiyCodeState extends State<VerfiyCode> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyCodeCubit(AuthRepository()),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            // If the user has no first and last name, ask for information first
            final user = state.user;
            // The project's UserModel uses `name`; backend may provide first_name/last_name.
            // Consider user needs info when `name` is null or empty.
            final needsInfo = user.name == null || user.name!.trim().isEmpty;
            if (needsInfo) {
              Navigator.of(context).pushReplacementNamed(AppRoute.information);
            } else {
              Navigator.of(context).pushReplacementNamed(AppRoute.home);
            }
          } else if (state is ResendCodeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ تم إعادة إرسال الكود")),
            );
          } else if (state is VerifyCodeFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomArrow(
                        onTap: () => Navigator.of(context).pop(),
                        color: AppColor.Dark,
                        background: AppColor.white,
                      ),
                      SizedBox(height: 10.h),
                      CustomTitle(
                        title: "Enter the Code",
                        color: AppColor.white,
                      ),
                      SizedBox(height: 8.h),
                      CustomSubTitle(
                        subtitle:
                            "Enter the verification code we just sent to ${widget.phone}",
                        color: AppColor.gry,
                        fontsize: 14.sp,
                      ),
                      SizedBox(height: 45.h),
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
                          onCompleted: (v) {
                            cubit.verifyCode(phone: widget.phone, code: v);
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: state is ResendCodeLoading
                            ? null
                            : () {
                                cubit.resendCode(widget.phone);
                              },
                        child: CustomSubTitle(
                          subtitle: state is ResendCodeLoading
                              ? "Sending..."
                              : "Resend Code",
                          color: AppColor.primaryColor,
                          fontsize: 12.sp,
                        ),
                      ),
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
