import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(locale: const Locale('en')));

  static const _prefKey = 'app_language_code';

  /// ينادى عند تشغيل التطبيق
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey);

    if (saved != null && saved.isNotEmpty) {
      emit(LanguageState(locale: Locale(saved)));
      return;
    }

    // لغة الجهاز
    final device = PlatformDispatcher.instance.locale;
    final lang = (device.languageCode == 'ar') ? 'ar' : 'en';
    emit(LanguageState(locale: Locale(lang)));
  }

  Future<void> setArabic() => setLocale(const Locale('ar'));
  Future<void> setEnglish() => setLocale(const Locale('en'));

  Future<void> setLocale(Locale locale) async {
    emit(LanguageState(locale: locale));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, locale.languageCode);
  }
}
