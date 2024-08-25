// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginState {}

final class LoginInitial extends LoginState {}

//! State for Login Text Change Event
class LoginFormInvalidState extends LoginState {
  late String? usernameError;
  late String? passwordError;
  LoginFormInvalidState({
    required this.usernameError,
    required this.passwordError,
  });
}

class LoginFormValidState extends LoginState {}

//! State for Login Form Submit Event
class LoginFormSubmitSuccessState extends LoginState {
  late String successMessage;
  LoginFormSubmitSuccessState({
    required this.successMessage,
  });
}

class LoginFormSubmitFailedState extends LoginState {
  late String failedMessage;
  LoginFormSubmitFailedState({
    required this.failedMessage,
  });
}
