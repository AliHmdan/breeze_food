import 'package:breezefood/presentation/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Animated extends StatefulWidget {
  const Animated({super.key});

  @override
  State<Animated> createState() => _AnimatedState();
}

class _AnimatedState extends State<Animated> {
  @override
  Widget build(BuildContext context) {
    return  AnimatedBackground(
                height: 100.h,
                child: Center(
                  child: Text(
                    'مرحباً 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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