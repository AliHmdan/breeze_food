import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FullscreenImageViewer extends StatefulWidget {
  final String imagePath;
  final String heroTag;

  const FullscreenImageViewer({
    super.key,
    required this.imagePath,
    required this.heroTag,
  });

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer>
    with SingleTickerProviderStateMixin {
  final TransformationController _tc = TransformationController();
  late final AnimationController _animCtrl;
  Animation<Matrix4>? _resetAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        if (_resetAnim != null) _tc.value = _resetAnim!.value;
      });
  }

  @override
  void dispose() {
    _tc.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _animateReset() {
    _resetAnim = Matrix4Tween(
      begin: _tc.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية مظلمة
      body: SafeArea(
        child: Stack(
          children: [
            // الصورة مع تكبير داخلي
            Positioned.fill(
              child: Hero(
                tag: widget.heroTag,
                child: InteractiveViewer(
                  transformationController: _tc,
                  minScale: 1.0,
                  maxScale: 3.0,
                  boundaryMargin: const EdgeInsets.all(32),
                  onInteractionEnd: (_) {
                    // لو ما في زوم أو تقريب بسيط، ارجع للوضع الطبيعي
                    if (_tc.value != Matrix4.identity()) _animateReset();
                  },
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // زر الإغلاق (Close)
            Positioned(
              top: 12,
              right: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      splashRadius: 26,
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                      tooltip: 'Close',
                    ),
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
