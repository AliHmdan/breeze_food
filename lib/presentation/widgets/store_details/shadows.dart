import 'package:flutter/material.dart';

/// ظلّ فاصل بين الصورة والخلفية السوداء
const kLiftedEdgeShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.45), // = Colors.black.withOpacity(0.45)
  blurRadius: 24,
  spreadRadius: -4,
  offset: Offset(0, -2),
);
