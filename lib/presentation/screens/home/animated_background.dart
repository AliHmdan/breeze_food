import 'package:freeza_food/presentation/widgets/animated_background.dart';
import 'package:freeza_food/data/model/home_model.dart' as home_model;
import 'package:freeza_food/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Animated extends StatefulWidget {
  final home_model.AdModel? ad;

  const Animated({super.key, this.ad});

  @override
  State<Animated> createState() => _AnimatedState();
}

class _AnimatedState extends State<Animated> {
  @override
  Widget build(BuildContext context) {
    final hasAd = widget.ad != null;
    Widget child = Center(
      child: Text(
        'hjghhhhhhhhhhhhhhhhhhhhh',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (hasAd) {
      final a = widget.ad!;
      final base = AppLink.server.replaceFirst('/api', '');
      final src = a.image.startsWith('http') ? a.image : '$base${a.image}';
      child = Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            src,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(color: Colors.grey.shade800),
          ),
          Center(
            child: Text(
              a.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                shadows: [const Shadow(blurRadius: 4, color: Colors.black)],
              ),
            ),
          ),
        ],
      );
    }

    return AnimatedBackground(
      height: 100.h,
      child: child,
      characters: const [
        CartoonSvg(
          alignment: Alignment.topRight,
          width: 56,
          assetPath: 'assets/characters/star.svg',
          margin: EdgeInsets.only(top: 10, right: 10),
          floatAmplitude: 4,
          phaseShift: 1.2,
        ),
        CartoonSvg(
          alignment: Alignment.bottomLeft,
          width: 90,
          assetPath: 'assets/characters/astronaut.svg',
          margin: EdgeInsets.only(left: 12, bottom: 8),
          rotationDeg: -6,
          floatAmplitude: 6,
          phaseShift: 0.0,
        ),
        CartoonSvg(
          alignment: Alignment.bottomRight,
          width: 110,
          assetPath: 'assets/characters/planet.svg',
          margin: EdgeInsets.only(right: 14, bottom: 6),
          floatAmplitude: 8,
          phaseShift: 2.2,
        ),
      ],
    );
  }
}
