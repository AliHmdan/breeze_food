// lib/presentation/ads/referral_ad_page.dart
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/screens/ads/widget/action_pill.dart';
import 'package:breezefood/presentation/screens/ads/widget/circle_icon_button.dart';
import 'package:breezefood/presentation/screens/ads/widget/gradient_background.dart';
import 'package:breezefood/presentation/screens/ads/widget/referral_code_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ReferralAdPage extends StatelessWidget {
  const ReferralAdPage({
    super.key,
    this.title = 'Invite a friend and win',
    this.highlight = '20',
    this.currency = 'SAR',
    this.line1 = 'You get \$10 on your friend first order',
    this.line2 = 'And an additional \$10 on his second order',
    this.referralCode = 'BF-7X2K9',
  });

  final String title;
  final String highlight;
  final String currency;
  final String line1;
  final String line2;
  final String referralCode;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GradientBackground(height: h),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: h * 0.02),

                  // العنوان
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: AppColor.Dark,
                        height: 1.2,
                      ),
                      children: [
                        const TextSpan(text: 'invite a friend\n'),
                        const TextSpan(text: 'And get'),
                        TextSpan(
                          text: '$currency$highlight',
                          style: const TextStyle(
                            color: AppColor.Dark,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  Text(
                    line1,
                    style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    line2,
                    style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: h * 0.035),

                  // أيقونة وسطية
                  Center(
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.primaryColor.withOpacity(.35),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.card_giftcard_rounded,
                        size: 38,
                        color: AppColor.Dark,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  ReferralCodeBox(code: referralCode),

                  const SizedBox(height: 16),

                  Center(
                    child: ActionPill(
                      onCopy: () async {
                        await Clipboard.setData(
                          ClipboardData(text: referralCode),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Referral code copied'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      onShare: () async {
                        final shareText =
                            'جرّب تطبيقنا واستخدم كود الإحالة "$referralCode" للحصول على مكافأة!';
                        await Share.share(shareText);
                      },
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final shareText =
                            'دعوتك جاهزة! استخدم هذا الرابط مع الكود "$referralCode".';
                        await Share.share(shareText);
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          'Share invite link',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: AppColor.red,
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
