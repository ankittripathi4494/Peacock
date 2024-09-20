// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/auto_schedule_task.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_dropdown_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_radio_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_text_form_widget.dart';
import 'package:pecockapp/global/widgets/toast.dart';
import 'package:pecockapp/modules/customer/bloc/customer_bloc.dart';
import 'package:pecockapp/modules/customer/bloc/customer_event.dart';
import 'package:pecockapp/modules/customer/bloc/customer_state.dart';
import 'package:pecockapp/modules/customer/model/all_customers_list_response_model.dart';
import 'package:pecockapp/modules/customer/model/city_response_model.dart';
import 'package:pecockapp/modules/customer/model/country_response_model.dart';
import 'package:pecockapp/modules/customer/model/state_response_model.dart';

class EditCustomerWidget extends StatefulWidget {
  late Map<String, dynamic> argus;
  EditCustomerWidget({super.key, required this.argus});

  @override
  State<EditCustomerWidget> createState() => _EditCustomerWidgetState();
}

class _EditCustomerWidgetState extends State<EditCustomerWidget> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerDobController = TextEditingController();
  Map<String, dynamic>? selectedGender;
  Map<String, dynamic>? selectedMarriageStatus;
  DateTime? selectedCustomerDOB;

  CountryResponseData? selectedCountry;
  StateResponseData? selectedState;
  CityResponseData? selectedCity;

  List<CountryResponseData>? countryList = [];
  List<StateResponseData>? stateList = [];
  List<CityResponseData>? cityList = [];

  @override
  void initState() {
    fetchCustomerDetails();
    fetchCountry();

    super.initState();
  }

  fetchCountry() {
    BlocProvider.of<CustomerBloc>(context).add(CustomerCountryFetchEvent());
  }

  fetchState({CountryResponseData? selectedCountry}) {
    BlocProvider.of<CustomerBloc>(context)
        .add(CustomerStateFetchEvent(countryResponseData: selectedCountry));
  }

  fetchCity(
      {CountryResponseData? selectedCountry,
      StateResponseData? selectedState}) {
    BlocProvider.of<CustomerBloc>(context).add(CustomerCityFetchEvent(
        countryResponseData: selectedCountry,
        stateResponseData: selectedState));
  }

  fetchCustomerDetails() {
    if (widget.argus.containsKey('data')) {
      AllCustomersListResponseData data =
          (widget.argus['data'] as AllCustomersListResponseData);

      LoggerUtil().errorData(data);
      setState(() {
        customerNameController.text = data.name ?? '';
        customerEmailController.text = data.email ?? '';
        customerPhoneController.text = data.mobile ?? '';

        String inputDate =
            data.dob.toString(); // Input date string: '12-03-1995'

// Parse the input date using the correct format
        DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(inputDate);

// Format the parsed date into the desired format
        customerDobController.text = DateFormat('d-M-y').format(parsedDate);
      });

      for (var gl in genderList) {
        if (int.parse(gl['input'].toString()) == data.gender) {
          setState(() {
            selectedGender = gl;
          });
        }
      }
      for (var msl in marriageStatusList) {
        if (int.parse(msl['input'].toString()) == data.marriageStatus) {
          setState(() {
            selectedMarriageStatus = msl;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          return Form(
              child: Column(
            children: [
              (state is EditCustomerSuccessState)
                  ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/customer-list');

                      ToastedNotification.successToast(context,
                          description: state.successMessage);
                    }, taskWaitDuration: Durations.short4)
                  : const SizedBox.shrink(),
              (state is EditCustomerFailedState)
                  ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                      Navigator.pushReplacementNamed(context, '/edit-customer',
                          arguments: widget.argus);
                      ToastedNotification.errorToast(context,
                          description: state.failedMessage);
                    }, taskWaitDuration: Durations.short4)
                  : const SizedBox.shrink(),
              (state is CustomerCountryLoadedState)
                  ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                      setState(() {
                        countryList = state.countryResponseData;
                      });

                      if (widget.argus.containsKey('data')) {
                        AllCustomersListResponseData data = (widget
                            .argus['data'] as AllCustomersListResponseData);
                        for (CountryResponseData cl in countryList ?? []) {
                          if (int.parse(cl.id.toString()) ==
                              int.parse(data.countryId.toString())) {
                            setState(() {
                              selectedCountry = cl;
                            });
                            fetchState(selectedCountry: cl);
                          }
                        }
                      }

                      LoggerUtil()
                          .debugData("Country:- ${state.countryResponseData}");
                    }, taskWaitDuration: Durations.short4)
                  : const SizedBox.shrink(),
              (state is CustomerStateLoadedState)
                  ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                      setState(() {
                        stateList = state.stateResponseData;
                      });
                      if (widget.argus.containsKey('data')) {
                        AllCustomersListResponseData data = (widget
                            .argus['data'] as AllCustomersListResponseData);
                        for (StateResponseData sl in stateList ?? []) {
                          if (int.parse(sl.id.toString()) ==
                              int.parse(data.stateId.toString())) {
                            setState(() {
                              selectedState = sl;
                            });
                            fetchCity(
                                selectedCountry: selectedCountry,
                                selectedState: sl);
                          }
                        }
                      }
                      LoggerUtil()
                          .debugData("State:- ${state.stateResponseData}");
                    }, taskWaitDuration: Durations.short4)
                  : const SizedBox.shrink(),
              (state is CustomerCityLoadedState)
                  ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                      setState(() {
                        cityList = state.cityResponseData;
                      });
                      if (widget.argus.containsKey('data')) {
                        AllCustomersListResponseData data = (widget
                            .argus['data'] as AllCustomersListResponseData);
                        for (CityResponseData cil in cityList ?? []) {
                          if (int.parse(cil.id.toString()) ==
                              int.parse(data.cityId.toString())) {
                            setState(() {
                              selectedCity = cil;
                            });
                          }
                        }
                      }
                      LoggerUtil()
                          .debugData("City:- ${state.cityResponseData}");
                    }, taskWaitDuration: Durations.short4)
                  : const SizedBox.shrink(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: customerNameController,
                  keyboardType: TextInputType.name,
                  labelText: "Customer Name",
                  normalIcon: Icons.person,
                  onChanged: (value) {
                    BlocProvider.of<CustomerBloc>(context).add(
                        CustomerTextChangeEvent(
                            customerName: customerNameController.text,
                            customerEmail: customerEmailController.text,
                            customerPhone: customerPhoneController.text,
                            customerGender: selectedGender,
                            customerMarriageStatus: selectedMarriageStatus,
                            customerDob: selectedCustomerDOB,
                            selectedCountry: selectedCountry,
                            selectedState: selectedState,
                            selectedCity: selectedCity));
                  },
                  errorText: (state is CustomerFormInvalidState)
                      ? state.customerName
                      : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: customerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Customer E-Mail",
                  onChanged: (value) {
                    BlocProvider.of<CustomerBloc>(context).add(
                        CustomerTextChangeEvent(
                            customerName: customerNameController.text,
                            customerEmail: customerEmailController.text,
                            customerPhone: customerPhoneController.text,
                            customerGender: selectedGender,
                            customerMarriageStatus: selectedMarriageStatus,
                            customerDob: selectedCustomerDOB,
                            selectedCountry: selectedCountry,
                            selectedState: selectedState,
                            selectedCity: selectedCity));
                  },
                  errorText: (state is CustomerFormInvalidState)
                      ? state.customerEmail
                      : null,
                  normalIcon: Icons.person,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@. ]'))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: customerPhoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    BlocProvider.of<CustomerBloc>(context).add(
                        CustomerTextChangeEvent(
                            customerName: customerNameController.text,
                            customerEmail: customerEmailController.text,
                            customerPhone: customerPhoneController.text,
                            customerGender: selectedGender,
                            customerMarriageStatus: selectedMarriageStatus,
                            customerDob: selectedCustomerDOB,
                            selectedCountry: selectedCountry,
                            selectedState: selectedState,
                            selectedCity: selectedCity));
                  },
                  maxLength: 10,
                  errorText: (state is CustomerFormInvalidState)
                      ? state.customerPhone
                      : null,
                  labelText: "Customer Phone",
                  normalIcon: Icons.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: const Text(
                    "Select Gender",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: CustomDropdown(
                      items: genderList,
                      hint: "Select Gender",
                      selectedValue: selectedGender,
                      errorText: (state is CustomerFormInvalidState)
                          ? state.customerGender
                          : null,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                        BlocProvider.of<CustomerBloc>(context).add(
                            CustomerTextChangeEvent(
                                customerName: customerNameController.text,
                                customerEmail: customerEmailController.text,
                                customerPhone: customerPhoneController.text,
                                customerGender: selectedGender,
                                customerMarriageStatus: selectedMarriageStatus,
                                customerDob: selectedCustomerDOB,
                                selectedCountry: selectedCountry,
                                selectedState: selectedState,
                                selectedCity: selectedCity));
                      },
                      getTitle: (item) => item['title']),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: const Text(
                    "Select Marriage Status",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: CustomRadioButtons(
                      items: marriageStatusList,
                      selectedValue: selectedMarriageStatus,
                      errorText: (state is CustomerFormInvalidState)
                          ? state.customerMarriageStatus
                          : null,
                      onChanged: (value) {
                        setState(() {
                          selectedMarriageStatus = value;
                        });
                        BlocProvider.of<CustomerBloc>(context).add(
                            CustomerTextChangeEvent(
                                customerName: customerNameController.text,
                                customerEmail: customerEmailController.text,
                                customerPhone: customerPhoneController.text,
                                customerGender: selectedGender,
                                customerMarriageStatus: selectedMarriageStatus,
                                customerDob: selectedCustomerDOB,
                                selectedCountry: selectedCountry,
                                selectedState: selectedState,
                                selectedCity: selectedCity));
                      },
                      getTitle: (item) => item['title']),
                ),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100))
                      .then((c) {
                    setState(() {
                      selectedCustomerDOB = c;
                      customerDobController.text =
                          DateFormat('d-M-y').format(c ?? DateTime.now());
                    });
                    BlocProvider.of<CustomerBloc>(context).add(
                        CustomerTextChangeEvent(
                            customerName: customerNameController.text,
                            customerEmail: customerEmailController.text,
                            customerPhone: customerPhoneController.text,
                            customerGender: selectedGender,
                            customerMarriageStatus: selectedMarriageStatus,
                            customerDob: selectedCustomerDOB,
                            selectedCountry: selectedCountry,
                            selectedState: selectedState,
                            selectedCity: selectedCity));
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomTextFormField(
                    prefix: const Icon(
                      Icons.calendar_month,
                      size: 50,
                      color: Colors.white,
                    ),
                    controller: customerDobController,
                    enabled: false,
                    labelText: "Select DOB",
                    errorText: (state is CustomerFormInvalidState)
                        ? state.customerdob
                        : null,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: const Text(
                    "Select Country",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: CustomDropdown(
                      items: countryList!,
                      hint: "Select Country",
                      selectedValue: selectedCountry,
                      errorText: (state is CustomerFormInvalidState)
                          ? state.countryError
                          : null,
                      onChanged: (value) {
                        setState(() {
                          stateList = [];
                          selectedState = null;
                          cityList = [];
                          selectedCity = null;
                          selectedCountry = value;
                        });
                        fetchState(selectedCountry: value);
                      },
                      getTitle: (item) => item.name!),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: const Text(
                    "Select State",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: CustomDropdown(
                      items: stateList!,
                      hint: "Select State",
                      selectedValue: selectedState,
                      errorText: (state is CustomerFormInvalidState)
                          ? state.stateError
                          : null,
                      onChanged: (value) {
                        setState(() {
                          cityList = [];
                          selectedCity = null;
                          selectedState = value;
                        });
                        fetchCity(
                            selectedState: value,
                            selectedCountry: selectedCountry);
                      },
                      getTitle: (item) => item.name!),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: const Text(
                    "Select City",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: CustomDropdown(
                      items: cityList!,
                      hint: "Select City",
                      selectedValue: selectedCity,
                      errorText: (state is CustomerFormInvalidState)
                          ? state.cityError
                          : null,
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                      getTitle: (item) => item.name!),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: (state is CustomerFormValidState)
                    ? InkWell(
                        onTap: () {
                          if (selectedCountry == null) {
                            ToastedNotification.errorToast(context,
                                description: "Please select country");
                          } else if (selectedState == null) {
                            ToastedNotification.errorToast(context,
                                description: "Please select state");
                          } else if (selectedState == null) {
                            ToastedNotification.errorToast(context,
                                description: "Please select city");
                          } else {
                            BlocProvider.of<CustomerBloc>(context).add(
                                EditCustomerEvent(
                                    customerName: customerNameController.text,
                                    customerEmail: customerEmailController.text,
                                    customerPhone: customerPhoneController.text,
                                    customerGender: selectedGender,
                                    customerMarriageStatus:
                                        selectedMarriageStatus,
                                    customerDob: selectedCustomerDOB,
                                    selectedCountry: selectedCountry,
                                    selectedState: selectedState,
                                    selectedCity: selectedCity,
                                    customerId: (widget.argus['data']
                                            as AllCustomersListResponseData)
                                        .id
                                        .toString()));
                          }
                        },
                        child: Container(
                          width: context.screenWidth,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.deepOrange,
                          ),
                          child: const Center(
                            child: Text(
                              "Edit Customer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          width: context.screenWidth,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey,
                          ),
                          child: const Center(
                            child: Text(
                              "Edit Customer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ));
        },
      ),
    );
  }
}
