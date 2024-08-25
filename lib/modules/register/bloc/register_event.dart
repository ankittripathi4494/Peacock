// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterEvent {}

class RegisterTextChangedEvent extends RegisterEvent {
  late String usernameText;
  late String passwordText;
  late String confirmPasswordText;
  late Map<String, dynamic>? selectedGender;
  late Map<String, dynamic>? selectedMarriageStatus;
  RegisterTextChangedEvent({
    required this.usernameText,
    required this.passwordText,
    required this.confirmPasswordText,
    required this.selectedGender,
    required this.selectedMarriageStatus,
  });
}

class RegisterFormSubmitEvent extends RegisterEvent {
  late String usernameData;
  late String passwordData;
  late String confirmPasswordData;
  late Map<String, dynamic>? selectedGender;
  late Map<String, dynamic>? selectedMarriageStatus;
  RegisterFormSubmitEvent({
    required this.usernameData,
    required this.passwordData,
    required this.confirmPasswordData,
    required this.selectedGender,
    required this.selectedMarriageStatus,
  });
}
