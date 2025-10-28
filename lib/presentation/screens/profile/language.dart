import 'package:breezefood/blocs/language/language_cubit.dart';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final selected = state.locale.languageCode; // "en" أو "ar"

        return Scaffold(
          backgroundColor: AppColor.Dark,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomAppbarProfile(
                title: "Language",
                icon: Icons.arrow_back_ios,
                ontap: () => Navigator.pop(context),
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  _LangButton(
                    label: "English",
                    active: selected == "en",
                    onTap: () => context.read<LanguageCubit>().setEnglish(),
                  ),
                  SizedBox(height: 12.h),
                  _LangButton(
                    label: "العربية",
                    active: selected == "ar",
                    onTap: () => context.read<LanguageCubit>().setArabic(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LangButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _LangButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: active ? Colors.cyanAccent : Colors.grey[800],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
