// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginEvent {}

class LoginTextChangedEvent extends LoginEvent {
  late String usernameText;
  late String passwordText;
  LoginTextChangedEvent({
    required this.usernameText,
    required this.passwordText,
  });
}


class LoginFormSubmitEvent extends LoginEvent {
  late String usernameData;
  late String passwordData;
  LoginFormSubmitEvent({
    required this.usernameData,
    required this.passwordData,
  });
  
}
