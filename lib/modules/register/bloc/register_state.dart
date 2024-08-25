// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterState {}

final class RegisterInitial extends RegisterState {}

//! State for Register Text Change Event
class RegisterFormInvalidState extends RegisterState {
  late String? usernameError;
  late String? passwordError;
  late String? confirmPasswordError;
  late String? genderError;
  late String? marriageStatusError;
  RegisterFormInvalidState({
    required this.usernameError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.genderError,
    required this.marriageStatusError,
  });
}

class RegisterFormValidState extends RegisterState {}

//! State for Register Form Submit Event
class RegisterFormSubmitSuccessState extends RegisterState {
  late String successMessage;
  RegisterFormSubmitSuccessState({
    required this.successMessage,
  });
}

class RegisterFormSubmitFailedState extends RegisterState {
  late String failedMessage;
  RegisterFormSubmitFailedState({
    required this.failedMessage,
  });
}
