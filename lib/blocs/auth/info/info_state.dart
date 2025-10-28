// info_state.dart
import 'package:equatable/equatable.dart';

class InfoState extends Equatable {
  const InfoState();
  @override
  List<Object?> get props => [];
}

class InfoInitial extends InfoState {}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? birthday; // ISO
  const InfoLoaded({this.firstName, this.lastName, this.email, this.birthday});

  @override
  List<Object?> get props => [firstName, lastName, email, birthday];
}

class InfoFailure extends InfoState {
  final String message;
  const InfoFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class InfoSaving extends InfoState {}

class InfoSaved extends InfoState {
  final String? message;
  const InfoSaved([this.message]);
  @override
  List<Object?> get props => [message];
}
