// lib/presentation/ads/widgets/referral_code_box.dart
import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';

class ReferralCodeBox extends StatelessWidget {
  const ReferralCodeBox({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.red.withOpacity(.20), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(.20), // بديل الأسود
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.sell_rounded, color:AppColor.red),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              code,
              textAlign: TextAlign.start,
              style: const TextStyle(
                letterSpacing: 2.0,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColor.red,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.Dark.withOpacity(.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Referral Code',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
