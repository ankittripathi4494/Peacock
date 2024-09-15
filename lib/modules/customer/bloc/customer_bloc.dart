import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/api_list.dart';
import 'package:pecockapp/global/utils/database_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/modules/customer/bloc/customer_event.dart';
import 'package:pecockapp/modules/customer/bloc/customer_state.dart';
import 'package:http/http.dart' as http;
import 'package:pecockapp/modules/customer/model/city_response_model.dart';
import 'package:pecockapp/modules/customer/model/country_response_model.dart';
import 'package:pecockapp/modules/customer/model/state_response_model.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  //event -> takes input in the bloc
  //emit -> gives output out from the bloc
  DatabaseHelper dbh = DatabaseHelper();
  CustomerBloc() : super(CustomerInitial()) {
    on<CustomerTextChangeEvent>(_customerValidFunc);
    on<CustomerCountryFetchEvent>(_customerCountryFetchMethod);
    on<CustomerStateFetchEvent>(_customerStateFetchMethod);
    on<CustomerCityFetchEvent>(_customerCityFetchMethod);
    on<CustomerListFetchEvent>(_fetchCustomerList);
    on<AddCustomerEvent>(_addCustomerMethod);
    on<EditCustomerEvent>(_editCustomerMethod);
  }

  _customerValidFunc(
      CustomerTextChangeEvent event, Emitter<CustomerState> emit) {
    if ((event.customerName.isEmpty) &&
        (event.customerEmail.isEmpty) &&
        (event.customerPhone.isEmpty) &&
        (event.customerGender == null) &&
        (event.customerMarriageStatus == null) &&
        (event.customerDob == null) &&
        (event.selectedCountry == null) &&
        (event.selectedState == null) &&
        (event.selectedCity == null)) {
      emit(CustomerFormInvalidState(
          customerName: 'Please Enter Customer Name',
          customerEmail: 'Please Enter Customer E-Mail',
          customerPhone: 'Please Enter Customer Phone',
          customerGender: 'Please select Customer Gender',
          customerMarriageStatus: 'Please select Customer Marriage Status',
          customerdob: "Please select customer date of birth and time",
          countryError: "Please Select country",
          stateError: "Please select state",
          cityError: "Please select city"));
    } else if ((event.customerName.isNotEmpty) &&
        (event.customerEmail.isNotEmpty) &&
        (event.customerPhone.isNotEmpty) &&
        (event.customerGender != null) &&
        (event.customerMarriageStatus != null)) {
      // valid status
      emit(CustomerFormValidState());
    } else {
      // valid status
      emit(CustomerFormInvalidState(
          customerName: (event.customerName.isEmpty)
              ? 'Please Enter Customer Name'
              : null,
          customerEmail: (event.customerEmail.isEmpty)
              ? 'Please Enter Customer E-Mail'
              : (event.customerEmail.isValidEmail()
                  ? null
                  : 'Please Enter Correct E-Mail'),
          customerPhone: (event.customerPhone.isEmpty)
              ? 'Please Enter Confirm Password'
              : ((!event.customerPhone.isValidContact())
                  ? 'Please enter correct mobile number'
                  : null),
          customerGender:
              (event.customerGender == null) ? 'Please select Gender' : null,
          customerMarriageStatus: (event.customerMarriageStatus == null)
              ? 'Please select Marriage Status'
              : null,
          customerdob: (event.customerDob == null)
              ? 'Please select Date of Birth'
              : null,
          countryError:
              (event.selectedCountry == null) ? "Please Select country" : null,
          stateError:
              (event.selectedState == null) ? "Please select state" : null,
          cityError:
              (event.selectedCountry == null) ? "Please select city" : null));
    }
  }

  _customerCountryFetchMethod(
      CustomerCountryFetchEvent event, Emitter<CustomerState> emit) async {
    try {
      var map = {};
      map['search'] = '';
      http.Response apiRequest = await http.post(
          Uri.https(ApiList.mainDomain, ApiList.countryListAPI),
          body: map);

      LoggerUtil().debugData("Response Code := ${apiRequest.statusCode}");
      if (apiRequest.statusCode >= 200 && apiRequest.statusCode < 300) {
        CountryResponseModel countryResponseModel =
            CountryResponseModel.fromJson(jsonDecode(apiRequest.body));

        if (countryResponseModel.data!.isNotEmpty) {
          LoggerUtil().warningData("Success := List is not empty");
          emit(CustomerCountryLoadedState(
              countryResponseData: countryResponseModel.data,
              successMessage: "Data Loaded Successfully"));
        } else {
          LoggerUtil().errorData("Error := List is empty");
          emit(
              CustomerCountryLoadingFailedState(errorMessage: "List is empty"));
        }
      } else {
        LoggerUtil().errorData(
            "Error := 'Request Failed with Status ${apiRequest.statusCode}");
        emit(CustomerCountryLoadingFailedState(
            errorMessage:
                "Request Failed with Status ${apiRequest.statusCode}"));
      }
    } catch (e) {
      LoggerUtil().errorData("Error := ${e.toString()}");
      emit(CustomerCountryLoadingFailedState(errorMessage: e.toString()));
    }
  }

  _customerStateFetchMethod(
      CustomerStateFetchEvent event, Emitter<CustomerState> emit) async {
    try {
      var map = {};
      map['search'] = '';
      map['country_id'] = event.countryResponseData?.id;
      http.Response apiRequest = await http
          .post(Uri.https(ApiList.mainDomain, ApiList.stateListAPI), body: map);

      LoggerUtil().debugData("Response Code := ${apiRequest.statusCode}");
      if (apiRequest.statusCode >= 200 && apiRequest.statusCode < 300) {
        StateResponseModel stateResponseModel =
            StateResponseModel.fromJson(jsonDecode(apiRequest.body));

        if (stateResponseModel.data!.isNotEmpty) {
          LoggerUtil().warningData("Success := List is not empty");
          emit(CustomerStateLoadedState(
              stateResponseData: stateResponseModel.data,
              successMessage: "Data Loaded Successfully"));
        } else {
          LoggerUtil().errorData("Error := List is empty");
          emit(CustomerStateLoadingFailedState(errorMessage: "List is empty"));
        }
      } else {
        LoggerUtil().errorData(
            "Error := 'Request Failed with Status ${apiRequest.statusCode}");
        emit(CustomerStateLoadingFailedState(
            errorMessage:
                "Request Failed with Status ${apiRequest.statusCode}"));
      }
    } catch (e) {
      LoggerUtil().errorData("Error := ${e.toString()}");
      emit(CustomerStateLoadingFailedState(errorMessage: e.toString()));
    }
  }

  _customerCityFetchMethod(
      CustomerCityFetchEvent event, Emitter<CustomerState> emit) async {
    try {
      var map = {};
      map['search'] = '';
      map['country_id'] = event.countryResponseData?.id;
      map['state_id'] = event.stateResponseData?.id;
      http.Response apiRequest = await http
          .post(Uri.https(ApiList.mainDomain, ApiList.cityListAPI), body: map);

      LoggerUtil().debugData("Response Code := ${apiRequest.statusCode}");
      if (apiRequest.statusCode >= 200 && apiRequest.statusCode < 300) {
        CityResponseModel cityResponseModel =
            CityResponseModel.fromJson(jsonDecode(apiRequest.body));

        if (cityResponseModel.data!.isNotEmpty) {
          LoggerUtil().warningData("Success := List is not empty");
          emit(CustomerCityLoadedState(
              cityResponseData: cityResponseModel.data,
              successMessage: "Data Loaded Successfully"));
        } else {
          LoggerUtil().errorData("Error := List is empty");
          emit(CustomerCityLoadingFailedState(errorMessage: "List is empty"));
        }
      } else {
        LoggerUtil().errorData(
            "Error := 'Request Failed with Status ${apiRequest.statusCode}");
        emit(CustomerCityLoadingFailedState(
            errorMessage:
                "Request Failed with Status ${apiRequest.statusCode}"));
      }
    } catch (e) {
      LoggerUtil().errorData("Error := ${e.toString()}");
      emit(CustomerCityLoadingFailedState(errorMessage: e.toString()));
    }
  }

  _fetchCustomerList(
      CustomerListFetchEvent event, Emitter<CustomerState> emit) async {
    List<Map<String, dynamic>>? fetchRecound = await dbh.queryAllRows(
      "Customer",
    );
    try {
      if (fetchRecound.isNotEmpty) {
        emit(CustomerListLoadedState(
            customerListResponseData: fetchRecound,
            successMessage: "${fetchRecound.length} customer records found"));
      } else {
        emit(
            CustomerListLoadingFailedState(errorMessage: "No Customers Found"));
      }
    } catch (e) {
      emit(CustomerListLoadingFailedState(errorMessage: e.toString()));
    }
  }

  _addCustomerMethod(
      AddCustomerEvent event, Emitter<CustomerState> emit) async {
    Map<String, dynamic> inputMap = {};
    inputMap['name'] = event.customerName;
    inputMap['email'] = event.customerEmail;
    inputMap['dob'] = event.customerDob.toString();
    inputMap['gender'] = event.customerGender?["input"];
    inputMap['marriage_status'] = event.customerMarriageStatus?["input"];
    inputMap['mobile'] = event.customerPhone;
    inputMap['country_id'] = event.selectedCountry?.id;
    inputMap['state_id'] = event.selectedState?.id;
    inputMap['city_id'] = event.selectedCity?.id;
    inputMap['status'] = '1';
    LoggerUtil().warningData(inputMap);
    int result = await dbh.insert("Customer", inputMap);
    try {
      if (result > 0) {
        emit(AddCustomerSuccessState(
            successMessage: "$result customer added successfully"));
      } else {
        emit(AddCustomerFailedState(failedMessage: 'Failed to add customer'));
      }
    } catch (e) {
      emit(AddCustomerFailedState(failedMessage: e.toString()));
    }
  }

  _editCustomerMethod(EditCustomerEvent event, Emitter<CustomerState> emit) {}
}
