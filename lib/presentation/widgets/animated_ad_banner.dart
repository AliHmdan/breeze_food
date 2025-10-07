import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedAdBanner extends StatefulWidget {
  final String title;
  final List<Color> cycleColors;
  final Duration flashInterval;
  final double borderRadius;
  final double height;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onTap;

  const AnimatedAdBanner({
    super.key,
    required this.title,
    this.cycleColors = const [
      Color(0xFFEE5A24), // orange
      Color(0xFF27AE60), // green
      Color(0xFF2D9CDB), // blue
    ],
    this.flashInterval = const Duration(seconds: 3),
    this.borderRadius = 14.0,
    this.height = 120.0,
    this.leftIcon,
    this.rightIcon,
    this.onTap,
  });

  const AnimatedAdBanner.example({super.key, this.onTap})
      : title = 'Your Satisfaction Is Our Mission!',
        cycleColors = const [
          Color(0xFFEE5A24),
          Color(0xFF27AE60),
          Color(0xFF2D9CDB),
        ],
        flashInterval = const Duration(seconds: 3),
        borderRadius = 14.0,
        height = 140.0,
        leftIcon = const _CornerIcon(icon: Icons.restaurant),
        rightIcon = const _CornerIcon(icon: Icons.local_grocery_store);

  @override
  State<AnimatedAdBanner> createState() => _AnimatedAdBannerState();
}

class _AnimatedAdBannerState extends State<AnimatedAdBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentColorIndex = 0;
  Color _currentColor = Colors.orange;

  @override
  void initState() {
    super.initState();

    _currentColor = widget.cycleColors.first;

    _controller = AnimationController(
      vsync: this,
      duration: widget.flashInterval,
    )..repeat();

    _controller.addListener(() {
      if (_controller.value > 0.99) {
        setState(() {
          _currentColorIndex =
              (_currentColorIndex + 1) % widget.cycleColors.length;
          _currentColor = widget.cycleColors[_currentColorIndex];
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  RadialGradient _radialGradient(Color color) {
    return RadialGradient(
      colors: [
        color.withOpacity(0.9),
        color.withOpacity(0.6),
        color.withOpacity(0.3),
      ],
      stops: const [0.2, 0.6, 1.0],
      center: Alignment.center,
      radius: 1.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: widget.height,
        decoration: BoxDecoration(
          gradient: _radialGradient(_currentColor),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: _currentColor.withOpacity(0.4),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _SunLinesPainter(),
            ),
            Positioned(left: 12, top: 10, child: widget.leftIcon ?? const SizedBox()),
            Positioned(right: 12, bottom: 8, child: widget.rightIcon ?? const SizedBox()),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ☀️ خطوط أشعة الشمس الخفيفة
class _SunLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    const rays = 24;
    final radius = size.width * 0.9;

    for (var i = 0; i < rays; i++) {
      final angle = (i / rays) * 2 * math.pi;
      final start = Offset(center.dx + math.cos(angle) * (radius * 0.2),
          center.dy + math.sin(angle) * (radius * 0.2));
      final end = Offset(center.dx + math.cos(angle) * radius,
          center.dy + math.sin(angle) * radius);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CornerIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  const _CornerIcon({required this.icon, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(icon, size: size * 0.9, color: Colors.white70),
      ),
    );
  }
}
