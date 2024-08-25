import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/database_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/modules/register/bloc/register_event.dart';
import 'package:pecockapp/modules/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  DatabaseHelper dbh = DatabaseHelper();
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterTextChangedEvent>(_registerValidFunc);
    on<RegisterFormSubmitEvent>(_registerFormSubmitFunc);
  }

  _registerValidFunc(
      RegisterTextChangedEvent event, Emitter<RegisterState> emit) {
    if ((event.usernameText.isEmpty) &&
        (event.passwordText.isEmpty) &&
        (event.confirmPasswordText.isEmpty) &&
        (event.selectedGender == null) &&
        (event.selectedMarriageStatus == null)) {
      emit(RegisterFormInvalidState(
        usernameError: 'Please Enter Username',
        passwordError: 'Please Enter Password',
        confirmPasswordError: 'Please Enter Confirm Password',
        genderError: 'Please select Gender',
        marriageStatusError: 'Please select Marriage Status',
      ));
    } else if ((event.usernameText.isNotEmpty) &&
        (event.passwordText.isNotEmpty) &&
        (event.confirmPasswordText.isNotEmpty) &&
        (event.selectedGender != null) &&
        (event.selectedMarriageStatus != null) &&
        (event.passwordText.toString().toLowerCase().trim() ==
            event.confirmPasswordText.toString().toLowerCase().trim())) {
      // valid status
      emit(RegisterFormValidState());
    } else {
      // valid status
      emit(RegisterFormInvalidState(
        usernameError:
            (event.usernameText.isEmpty) ? 'Please Enter Username' : null,
        passwordError: (event.passwordText.isEmpty)
            ? 'Please Enter Password'
            : ((event.passwordText.toString().toLowerCase().trim() !=
                    event.confirmPasswordText.toString().toLowerCase().trim())
                ? 'Password and Confirm Password are not matched'
                : null),
        confirmPasswordError: (event.confirmPasswordText.isEmpty)
            ? 'Please Enter Confirm Password'
            : ((event.passwordText.toString().toLowerCase().trim() !=
                    event.confirmPasswordText.toString().toLowerCase().trim())
                ? 'Password and Confirm Password are not matched'
                : null),
        genderError:
            (event.selectedGender == null) ? 'Please select Gender' : null,
        marriageStatusError: (event.selectedMarriageStatus == null)
            ? 'Please select Marriage Status'
            : null,
      ));
    }
  }

  _registerFormSubmitFunc(
      RegisterFormSubmitEvent event, Emitter<RegisterState> emit) async {
    try {
      List<Map<String, dynamic>>? fetchRecound = await dbh
          .queryRowByClause("UserCredData", "username=?", [event.usernameData.trim()]);
      LoggerUtil().debugData(fetchRecound);

      if (fetchRecound!.isEmpty) {
        int insertResult = await dbh.insert("UserCredData", {
          "username": event.usernameData.trim(),
          "password": event.passwordData.trim(),
          "gender": event.selectedGender!['input'],
          "marriage_status": event.selectedMarriageStatus!['input'],
        });
        if (insertResult > 0) {
          emit(RegisterFormSubmitSuccessState(
              successMessage: "Registration Successfull"));
        } else {
          emit(RegisterFormSubmitFailedState(
              failedMessage: "Cannot Register. Please Try Again"));
        }
      } else {
        emit(RegisterFormSubmitFailedState(
            failedMessage:
                "Username already registered.Please choose another."));
      }
    } catch (e) {
      emit(RegisterFormSubmitFailedState(failedMessage: e.toString()));
    }
  }
}
