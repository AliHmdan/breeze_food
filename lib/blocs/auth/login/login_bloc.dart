
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await authRepository.login(event.phone);
        emit(LoginSuccess(result));
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
