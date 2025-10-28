import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:breezefood/data/model/profile/user_profile.dart';

class AuthState extends Equatable {
  final UserProfile? user;
  final bool loading;
  const AuthState({this.user, this.loading = false});

  AuthState copyWith({UserProfile? user, bool? loading}) =>
      AuthState(user: user ?? this.user, loading: loading ?? this.loading);

  @override
  List<Object?> get props => [user, loading];
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void setUser(UserProfile user) => emit(state.copyWith(user: user, loading: false));
  void clear() => emit(const AuthState(user: null, loading: false));
}
