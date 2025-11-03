import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('en')));

  static const _prefsKey = 'app_language_code';
  static const _supported = {'en', 'ar'};

  /// نادِها في main قبل runApp
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);

    if (saved != null && saved.isNotEmpty) {
      await _loadAndEmit(saved);
      return;
    }

    final device = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final code = _supported.contains(device) ? device : 'en';
    await _loadAndEmit(code);
    await prefs.setString(_prefsKey, code);
  }

  Future<void> setEnglish() => _setLang('en');
  Future<void> setArabic()  => _setLang('ar');

  Future<void> _setLang(String code) async {
    await _loadAndEmit(code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, code);
  }

  /// ✅ هذه هي الدالة التي طلبتها
  String t(String key) => state.texts[key]?.toString() ?? key;

  // ---------------- Helpers ----------------

  Future<void> _loadAndEmit(String code) async {
    final picked = _supported.contains(code) ? code : 'en';
    final map = await _loadJson(picked);
    emit(LanguageState(Locale(picked), texts: map));
  }

  Future<Map<String, dynamic>> _loadJson(String code) async {
    final s = await rootBundle.loadString('assets/lang/$code.json');
    return json.decode(s) as Map<String, dynamic>;
  }
}
