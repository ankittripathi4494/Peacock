// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pecockapp/modules/customer/model/country_response_model.dart';
import 'package:pecockapp/modules/customer/model/state_response_model.dart';

class CustomerEvent {}

//! Event 1 -> 2 and 3
class CustomerTextChangeEvent extends CustomerEvent {
  late String customerName;
  late String customerEmail;
  late String customerPhone;
  late Map<String, dynamic>? customerGender;
  late Map<String, dynamic>? customerMarriageStatus;
   late DateTime? customerDob;
  CustomerTextChangeEvent({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerGender,
    required this.customerMarriageStatus,
    required this.customerDob
  });
}
//! Event 2
class AddCustomerEvent extends CustomerEvent {
  late String customerName;
  late String customerEmail;
  late String customerPhone;
  late Map<String, dynamic>? customerGender;
  late Map<String, dynamic>? customerMarriageStatus;
  late DateTime? customerDob;
  AddCustomerEvent({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerGender,
    required this.customerMarriageStatus,
    required this.customerDob
  });
}
//! Event 3
class EditCustomerEvent extends CustomerEvent {
  late String customerId;
  late String customerName;
  late String customerEmail;
  late String customerPhone;
  late String customerGender;
  late String customerMarriageStatus;
  late DateTime? customerDob;
  EditCustomerEvent({
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerGender,
    required this.customerMarriageStatus,
    required this.customerDob
  });
}
//! Event 4
class CustomerListFetchEvent extends CustomerEvent {}
//! Event 5
class CustomerDetailsFetchEvent extends CustomerEvent {
  late String customerId;
  CustomerDetailsFetchEvent({
    required this.customerId,
  });
}

//! Event 6
class CustomerCountryFetchEvent extends CustomerEvent {}

//! Event 7
class CustomerStateFetchEvent extends CustomerEvent {
  late CountryResponseData? countryResponseData;
  CustomerStateFetchEvent({
    required this.countryResponseData,
  });
}

//! Event 8
class CustomerCityFetchEvent extends CustomerEvent {
  late CountryResponseData? countryResponseData;
   late StateResponseData? stateResponseData;
  CustomerCityFetchEvent({
    required this.countryResponseData,
    required this.stateResponseData,
  });
}



