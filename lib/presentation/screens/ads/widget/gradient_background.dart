// lib/presentation/ads/widgets/gradient_background.dart
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/screens/ads/widget/rays_painter.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // خلفية متدرجة فاتحة
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, .55),
                colors: [Color(0xFFEFFFFF), Color(0xFFF6FFFF)],
              ),
            ),
          ),
          // أشعة زخرفية
           Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: RaysPainter())),
          ),
          // توهج علوي
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColor.primaryColor.withOpacity(.28), Colors.transparent],
                ),
              ),
            ),
          ),
          // توهج سفلي
          Positioned(
            bottom: -140,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColor.primaryColor.withOpacity(.18), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
