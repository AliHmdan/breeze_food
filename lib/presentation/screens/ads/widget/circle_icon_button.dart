// lib/presentation/ads/widgets/circle_icon_button.dart
import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.9),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: AppColor.Dark),
        ),
      ),
    );
  }
}
