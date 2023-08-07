import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_repository.dart';
import '../form_submission_status.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepo;
  LoginBloc({this.authRepo}) : super(LoginState()) {
    on<LoginUserNameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onFormSubmitted);
  }

  // Event handler for LoginUserNameChanged
  void _onUsernameChanged(
      LoginUserNameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  // Event handler for LoginPasswordChanged
  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  // Event handler for LoginSubmitted
  void _onFormSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      await authRepo?.login();
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e)));
    }
  }
}
