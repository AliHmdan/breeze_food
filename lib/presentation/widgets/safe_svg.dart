import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

class SafeSvg extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const SafeSvg({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  String _sanitize(String s) {
    // احذف وسوم الفلاتر بالكامل
    s = s.replaceAll(RegExp(r'<filter[\s\S]*?</filter>', multiLine: true), '');
    // احذف مرجع الخاصية filter="url(#id)"
    s = s.replaceAll(RegExp(r'\sfilter="url\(#.*?\)"'), '');
    // اختياري: إزالة styles inline التي قد تحمل فلاتر
    s = s.replaceAll(RegExp(r'style="[^"]*filter:[^"]*"', multiLine: true), '');
    return s;
  }

  Future<String> _load() async {
    final raw = await rootBundle.loadString(asset);
    return _sanitize(raw);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _load(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done || !snap.hasData) {
          return SizedBox(width: width, height: height);
        }
        return SvgPicture.string(
          snap.data!,
          width: width,
          height: height,
          fit: fit,
          excludeFromSemantics: true,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      },
    );
  }
}
