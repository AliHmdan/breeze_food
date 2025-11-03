import 'package:flutter/material.dart';

class LanguageState {
  final Locale locale;
  final Map<String, dynamic> texts;

  const LanguageState(
    this.locale, {
    this.texts = const {},
  });

  LanguageState copyWith({Locale? locale, Map<String, dynamic>? texts}) {
    return LanguageState(
      locale ?? this.locale,
      texts: texts ?? this.texts,
    );
  }
}
