import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void _showShareOptions(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColor.Dark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Share with",
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareIcon(
                    "assets/icons/whatsapp.svg",
                    "WhatsApp",
                    Colors.green,
                    () {
                      Navigator.pop(context);
                      // أضف هنا منطق المشاركة الفعلي لاحقًا
                    },
                  ),
                  _buildShareIcon(
                    "assets/icons/facebook.svg",
                    "Facebook",
                    Colors.blueAccent,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareIcon(
                    "assets/icons/instagram.svg",
                    "Instagram",
                    Colors.purple,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareIcon(
                    "assets/icons/telegram.svg",
                    "Telegram",
                    Colors.lightBlueAccent,
                    () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildShareIcon(
    String assetPath, String label, Color color, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.2),
          child: SvgPicture.asset(
            assetPath,
            width: 28,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: AppColor.white, fontSize: 10),
        ),
      ],
    ),
  );
}
