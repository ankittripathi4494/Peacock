import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/modules/login/bloc/login_event.dart';
import 'package:pecockapp/modules/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginTextChangedEvent>(_loginValidFunc);
    on<LoginFormSubmitEvent>(_loginFormSubmitFunc);
  }

  _loginValidFunc(LoginTextChangedEvent event, Emitter<LoginState> emit) {
    if ((event.usernameText.isEmpty) && (event.passwordText.isEmpty)) {
      emit(LoginFormInvalidState(
        usernameError: 'Please Enter Username',
        passwordError: 'Please Enter Password',
      ));
    } else if ((event.usernameText.isNotEmpty) &&
        (event.passwordText.isNotEmpty)) {
      // valid status
      emit(LoginFormValidState());
    } else {
      emit(LoginFormInvalidState(
        usernameError:
            (event.usernameText.isEmpty) ? 'Please Enter Username' : null,
        passwordError:
            (event.passwordText.isEmpty) ? 'Please Enter Password' : null,
      ));
    }
  }

  _loginFormSubmitFunc(LoginFormSubmitEvent event, Emitter<LoginState> emit) {}
}
