// lib/presentation/ads/widgets/action_pill.dart
import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';

class ActionPill extends StatelessWidget {
  const ActionPill({
    super.key,
    required this.onCopy,
    required this.onShare,
  });

  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColor.Dark,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.Dark.withOpacity(.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pillButton(
            context,
            icon: Icons.copy_rounded,
            label: 'Copy',
            onTap: onCopy,
          ),
          const SizedBox(width: 6),
          Container(width: 1, height: 24, color: Colors.white.withOpacity(.22)),
          const SizedBox(width: 6),
          _pillButton(
            context,
            icon: Icons.share_rounded,
            label: 'Share',
            onTap: onShare,
          ),
        ],
      ),
    );
  }

  Widget _pillButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
             Icon(icon, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
