import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/database_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/utils/shared_preferences_helper.dart';
import 'package:pecockapp/modules/login/bloc/login_event.dart';
import 'package:pecockapp/modules/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  DatabaseHelper dbh = DatabaseHelper();
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

  _loginFormSubmitFunc(
      LoginFormSubmitEvent event, Emitter<LoginState> emit) async {
    LoggerUtil().errorData(event.toString());
    try {
      List<Map<String, dynamic>>? fetchRecound = await dbh.queryRowByClause(
          "UserCredData",
          "username=? and password=?",
          [event.usernameData.trim(), event.passwordData.trim()]);
      if (fetchRecound!.isNotEmpty) {
        sph.setBool("isLoggedIn", true);
        sph.setString("username", event.usernameData.trim());
        emit(LoginFormSubmitSuccessState(successMessage: "Login Successful"));
      } else {
        emit(LoginFormSubmitFailedState(
            failedMessage:
                "Cannot Login because user is not registered. Please Try Again"));
      }
    } catch (e) {
      emit(LoginFormSubmitFailedState(failedMessage: e.toString()));
    }
  }
}
