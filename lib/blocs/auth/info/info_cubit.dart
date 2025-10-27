// info_cubit.dart
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'info_state.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';

class InfoCubit extends Cubit<InfoState> {
  final AuthRepository repo;
  InfoCubit(this.repo) : super(InfoInitial());

  Future<void> _ensureAuthHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      repo.setAuthHeader(token);
    }
  }

  Future<void> load() async {
    emit(InfoLoading());
    try {
      await _ensureAuthHeader();
      final resp = await repo.getMe();
      if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
        final data = resp.data;
        // يدعم map أو string
        final map = (data is Map) ? Map<String, dynamic>.from(data) : jsonDecode(data as String);
        emit(InfoLoaded(
          firstName: map['first_name']?.toString(),
          lastName:  map['last_name']?.toString(),
          email:     map['email']?.toString(),
          birthday:  map['birthday']?.toString(), // مثل "1990-05-01T00:00:00.000000Z"
        ));
      } else {
        emit(InfoFailure(_extractMessage(resp.data) ?? 'فشل جلب البيانات'));
      }
    } on DioException catch (e) {
      emit(InfoFailure(_extractMessage(e.response?.data) ?? e.message ?? 'خطأ في الاتصال'));
    } catch (_) {
      emit(const InfoFailure('خطأ غير متوقع'));
    }
  }

  Future<void> save({
    required String firstName,
    required String lastName,
  }) async {
    emit(InfoSaving());
    try {
      await _ensureAuthHeader();
      final resp = await repo.updateMe(
        firstName: firstName,
        lastName: lastName,
      );
      if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
        emit(const InfoSaved('تم الحفظ بنجاح'));
        await load(); // رجّع البيانات المحدّثة
      } else {
        emit(InfoFailure(_extractMessage(resp.data) ?? 'فشل الحفظ'));
      }
    } on DioException catch (e) {
      emit(InfoFailure(_extractMessage(e.response?.data) ?? e.message ?? 'خطأ في الاتصال'));
    } catch (_) {
      emit(const InfoFailure('خطأ غير متوقع'));
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map) {
      final m = data['message'] ?? data['error'] ?? data['msg'] ?? data['status'];
      return m?.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }
}
