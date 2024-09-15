// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pecockapp/modules/customer/model/city_response_model.dart';
import 'package:pecockapp/modules/customer/model/country_response_model.dart';
import 'package:pecockapp/modules/customer/model/state_response_model.dart';

class CustomerState {}

final class CustomerInitial extends CustomerState {}

//! State for Customer Text Change Event
class CustomerFormInvalidState extends CustomerState {
  late String? customerName;
  late String? customerEmail;
  late String? customerPhone;
  late String? customerGender;
  late String? customerMarriageStatus;
  late String? customerdob;
  late String? countryError;
  late String? stateError;
  late String? cityError;
  CustomerFormInvalidState({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerGender,
    required this.customerMarriageStatus,
    required this.customerdob,
    required this.countryError,
    required this.stateError,
    required this.cityError,
  });
}

class CustomerFormValidState extends CustomerState {}

//! State for Add Customer Event

class AddCustomerLoadingState extends CustomerState {}

class AddCustomerSuccessState extends CustomerState {
  late String successMessage;
  AddCustomerSuccessState({
    required this.successMessage,
  });
}

class AddCustomerFailedState extends CustomerState {
  late String failedMessage;
  AddCustomerFailedState({
    required this.failedMessage,
  });
}

//! State for Edit Customer Event

class EditCustomerLoadingState extends CustomerState {}

class EditCustomerSuccessState extends CustomerState {
  late String successMessage;
  EditCustomerSuccessState({
    required this.successMessage,
  });
}

class EditCustomerFailedState extends CustomerState {
  late String failedMessage;
  EditCustomerFailedState({
    required this.failedMessage,
  });
}

//! State for Delete Customer Event

class DeleteCustomerLoadingState extends CustomerState {}

class DeleteCustomerSuccessState extends CustomerState {
  late String successMessage;
  DeleteCustomerSuccessState({
    required this.successMessage,
  });
}

class DeleteCustomerFailedState extends CustomerState {
  late String failedMessage;
  DeleteCustomerFailedState({
    required this.failedMessage,
  });
}

//! State for Customer Country Fetch Event

class CustomerCountryLoadingState extends CustomerState {}

class CustomerCountryLoadedState extends CustomerState {
  late List<CountryResponseData>? countryResponseData;
  late String? successMessage;
  CustomerCountryLoadedState({
    required this.countryResponseData,
    required this.successMessage,
  });
}

class CustomerCountryLoadingFailedState extends CustomerState {
  late String? errorMessage;
  CustomerCountryLoadingFailedState({
    required this.errorMessage,
  });
}

//! State for Customer State Fetch Event

class CustomerStateLoadingState extends CustomerState {}

class CustomerStateLoadedState extends CustomerState {
  late List<StateResponseData>? stateResponseData;
  late String? successMessage;
  CustomerStateLoadedState({
    required this.stateResponseData,
    required this.successMessage,
  });
}

class CustomerStateLoadingFailedState extends CustomerState {
  late String? errorMessage;
  CustomerStateLoadingFailedState({
    required this.errorMessage,
  });
}

//! State for Customer City Fetch Event

class CustomerCityLoadingState extends CustomerState {}

class CustomerCityLoadedState extends CustomerState {
  late List<CityResponseData>? cityResponseData;
  late String? successMessage;
  CustomerCityLoadedState({
    required this.cityResponseData,
    required this.successMessage,
  });
}

class CustomerCityLoadingFailedState extends CustomerState {
  late String? errorMessage;
  CustomerCityLoadingFailedState({
    required this.errorMessage,
  });
}

//! State for Customer List Fetch Event

class CustomerListLoadingState extends CustomerState {}

class CustomerListLoadedState extends CustomerState {
  late List<Map<String, dynamic>>? customerListResponseData;
  late String? successMessage;
  CustomerListLoadedState({
    required this.customerListResponseData,
    required this.successMessage,
  });
}

class CustomerListLoadingFailedState extends CustomerState {
  late String? errorMessage;
  CustomerListLoadingFailedState({
    required this.errorMessage,
  });
}
