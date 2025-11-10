import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui; // للـ BackdropFilter (ImageFilter)
import 'fullscreen_image_viewer.dart';

class PinchZoomHeader extends StatefulWidget {
  final String imagePath;
  final double height;
  final double maxScale;

  // جديد:
  final bool enableTapToFullscreen;
  final String heroTag;

  const PinchZoomHeader({
    super.key,
    required this.imagePath,
    required this.height,
    this.maxScale = 1.25,
    this.enableTapToFullscreen = true,
    this.heroTag = 'storeHeaderHero', // تأكّد يكون فريد لو عندك أكثر من صورة
  });

  @override
  State<PinchZoomHeader> createState() => _PinchZoomHeaderState();
}

class _PinchZoomHeaderState extends State<PinchZoomHeader>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0; // تكبير الصبعين داخل الهيدر
  double _base = 1.0;
  late final AnimationController _ctrl;
  late Animation<double> _anim;

  static const double _min = 1.0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(() => setState(() => _scale = _anim.value));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _backToNormal() {
    _anim = Tween<double>(begin: _scale, end: 1.0)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_ctrl);
    _ctrl.forward(from: 0);
  }

  void _openFullscreen() {
    if (!widget.enableTapToFullscreen) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, __, ___) => FullscreenImageViewer(
          imagePath: widget.imagePath,
          heroTag: widget.heroTag,
        ),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double topSafe = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ===== الصورة مع التكبير =====
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _openFullscreen, // النقر لفتح ملء الشاشة
            onScaleStart: (d) {
              _ctrl.stop();
              _base = _scale;
            },
            onScaleUpdate: (d) {
              if (d.pointerCount >= 2) {
                final next = (_base * d.scale).clamp(_min, widget.maxScale);
                setState(() => _scale = next);
              }
            },
            onScaleEnd: (_) => _backToNormal(),
            child: Hero(
              tag: widget.heroTag,
              child: Transform.scale(
                scale: _scale,
                alignment: Alignment.center,
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // ===== أيقونات التحكم (رجوع + مشاركة) =====
          Positioned(
            top: topSafe + 8, // يحترم الـ notch/status bar
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomArrow(onTap: (){
                  Navigator.pop(context);
                }, color: AppColor.white, background: AppColor.Dark),
               GestureDetector(onTap: (){},
                 child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColor.Dark,
                      child: SvgPicture.asset(
                        "assets/icons/share.svg",
                        width: 20,
                        height: 20,
                        color: AppColor.white,
                      ),
                    ),
               ),
              ],
            ),
          ),

          // ===== التدرّج السفلي لدمج الصورة مع الخلفية =====
          const _BottomFade(),
        ],
      ),
    );
  }

  /// زر علوي بخلفية زجاجية (blur) وشفافية أنيقة
  Widget _buildTopButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 22),
            onPressed: onTap,
            splashRadius: 26,
            tooltip: '',
          ),
        ),
      ),
    );
  }
}

class _BottomFade extends StatelessWidget {
  const _BottomFade();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      left: 0, right: 0, bottom: 0, height: 100,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
