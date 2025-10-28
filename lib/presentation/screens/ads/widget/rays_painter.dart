// lib/presentation/ads/widgets/rays_painter.dart
import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';


class RaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final base = AppColor.primaryColor;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = base.withOpacity(0.08);

    const int slices = 9;
    final double step = size.width / slices;
    for (int i = 0; i < slices; i++) {
      final path = Path()
        ..moveTo(i * step, 0)
        ..lineTo((i + .7) * step, 0)
        ..lineTo(size.width * .55, size.height * .80)
        ..lineTo(size.width * .45, size.height * .80)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
