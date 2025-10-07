import 'dart:async';
import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final double height; // ← يمكنك تحديد الارتفاع من الخارج إذا رغبت
  const AnimatedBackground({
    super.key,
    required this.child,
    this.height = 300, // ← ارتفاع افتراضي
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  final List<Color> colors = [
    AppColor.LightActive,
    AppColor.yellow,
    AppColor.primaryColor,
  ];

  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % colors.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: widget.height,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: colors[currentIndex],
          borderRadius: BorderRadius.circular(11.r), // ← الزوايا الدائرية
        ),
        clipBehavior: Clip.antiAlias, // ← لتطبيق borderRadius على الرسم الداخلي
        child: CustomPaint(
          painter: StripePainter(),
          child: widget.child,
        ),
      ),
    );
  }
}

class StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    const stripeWidth = 80.0; // عرض الخطوط
    const gap = 40.0; // المسافة بين الخطوط

    for (double x = -size.height; x < size.width + size.height; x += stripeWidth + gap) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + stripeWidth, 0)
        ..lineTo(x + stripeWidth - size.height, size.height)
        ..lineTo(x - size.height, size.height)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
