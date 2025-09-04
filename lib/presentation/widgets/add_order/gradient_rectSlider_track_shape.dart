import 'package:flutter/material.dart';

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientRectSliderTrackShape();

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isEnabled = false,
        bool isDiscrete = false,
        required TextDirection textDirection,
      }) {
    if (sliderTheme.trackHeight == 0) return;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // الجزء الفعّال (من البداية لحد Thumb)
    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    // الجزء غير الفعّال (من Thumb للنهاية)
    final Rect inactiveRect = Rect.fromLTRB(
      thumbCenter.dx,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    // Gradient للجزء الفعّال
    final Paint activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.white, Colors.red],
      ).createShader(activeRect);

    // لون أبيض للجزء غير الفعّال
    final Paint inactivePaint = Paint()..color = Colors.white;

    // رسم الجزء الفعّال
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(10)),
      activePaint,
    );

    // رسم الجزء غير الفعّال
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(inactiveRect, const Radius.circular(10)),
      inactivePaint,
    );
  }
}
