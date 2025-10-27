import 'package:breezefood/blocs/profile/profile_state.dart';
import 'package:breezefood/data/model/profile/user_profile.dart';
import 'package:breezefood/data/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repo;
  ProfileCubit(this.repo) : super(ProfileInitial());

  Future<void> loadProfile(String token) async {
    emit(ProfileLoading());
    try { repo.setToken(token); emit(ProfileLoaded(await repo.getMe())); }
    catch (e) { emit(ProfileError(e.toString())); }
  }

  Future<void> saveProfile({
    required String token,
    required String? firstName,
    required String? lastName,
    required String? phone,
    required String? avatarCode, // <-- a1,a2...
    UserProfile? base,
  }) async {
    emit(ProfileSaving());
    try {
      repo.setToken(token);
      final payload = (base ?? UserProfile(id: 0)).copyWith(
        firstName: firstName,
        lastName : lastName,
        phone    : phone,
        avatar   : avatarCode, // <-- نرسل الكود فقط
      );
      final updated = await repo.updateProfile(payload);
      emit(ProfileSaved(updated));
      emit(ProfileLoaded(updated));
    } catch (e) { emit(ProfileError(e.toString())); }
  }
}
