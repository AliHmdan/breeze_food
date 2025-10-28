import 'package:freeza_food/data/model/profile/user_profile.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  ProfileLoaded(this.profile);
  @override
  List<Object?> get props => [profile];
}

class ProfileSaving extends ProfileState {}

class ProfileSaved extends ProfileState {
  final UserProfile profile;
  ProfileSaved(this.profile);
  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
