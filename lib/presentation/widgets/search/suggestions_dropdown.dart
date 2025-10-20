import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:breezefood/core/constans/color.dart';

/// قائمة اقتراحات منسدلة أسفل حقل البحث
class SuggestionsDropdown extends StatelessWidget {
  final GlobalKey fieldKey;
  final List<String> suggestions;
  final void Function(String value) onPick;
  final bool visible;

  const SuggestionsDropdown({
    super.key,
    required this.fieldKey,
    required this.suggestions,
    required this.onPick,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final renderBox = fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero);
    final topPosition = offset?.dy ?? 110.0;
    final double computed = (suggestions.length * 48.0.h);
    final double maxHeight = computed > 300.0.h ? 300.0.h : computed;

    return Positioned(
      top: topPosition + 45.h,
      left: 24.w,
      right: 24.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: suggestions.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      'No suggestions found',
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(10.w),
                  itemCount: suggestions.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: AppColor.black, height: 1.h),
                  itemBuilder: (context, index) {
                    final s = suggestions[index];
                    return InkWell(
                      onTap: () => onPick(s),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                        child: Text(
                          s,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 15.sp,
                            fontFamily: "Manrope",
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
