// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/auto_schedule_task.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_dropdown_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_radio_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_text_form_widget.dart';
import 'package:pecockapp/modules/customer/bloc/customer_bloc.dart';
import 'package:pecockapp/modules/customer/bloc/customer_event.dart';
import 'package:pecockapp/modules/customer/bloc/customer_state.dart';
import 'package:pecockapp/modules/customer/model/city_response_model.dart';
import 'package:pecockapp/modules/customer/model/country_response_model.dart';
import 'package:pecockapp/modules/customer/model/state_response_model.dart';

class AddCustomerWidget extends StatefulWidget {
  const AddCustomerWidget({
    super.key,
  });

  @override
  State<AddCustomerWidget> createState() => _AddCustomerWidgetState();
}

class _AddCustomerWidgetState extends State<AddCustomerWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              if (state is CustomerCountryLoadedState) {
                return AutoScheduleTaskWidget.taskScheduler(context,
                    task: () {
                  setState(() {
                    countryList = state.countryResponseData;
                  });
                   print(state.countryResponseData);
                }, taskWaitDuration: Durations.short4);
              }
              if (state is CustomerStateLoadedState) {
                return AutoScheduleTaskWidget.taskScheduler(context,
                    task: () {
                  setState(() {
                    stateList = state.stateResponseData;
                  });
                  print(state.stateResponseData);
                }, taskWaitDuration: Durations.short4);
              }
          if (state is CustomerCityLoadedState) {
                return AutoScheduleTaskWidget.taskScheduler(context,
                    task: () {
                  setState(() {
                    cityList = state.cityResponseData;
                  });
                }, taskWaitDuration: Durations.short4);
              }
              return const SizedBox.shrink();
            },
          ),
          
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: CustomTextFormField(
              controller: customerNameController,
              keyboardType: TextInputType.name,
              labelText: "Customer Name",
              normalIcon: Icons.person,
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
              maxLength: 10,
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
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
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
                  onChanged: (value) {
                    setState(() {
                      selectedMarriageStatus = value;
                    });
                  },
                  getTitle: (item) => item['title']),
            ),
          ),
          Container(
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
                  onChanged: (value) {
                    setState(() {
                      cityList = [];
                      selectedCity = null;
                      selectedState = value;
                    });
                    fetchCity(
                        selectedState: value, selectedCountry: selectedCountry);
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
            child: InkWell(
              onTap: () {},
              child: Container(
                width: context.screenWidth,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: const Center(
                  child: Text(
                    "Add Customer",
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
      ),
    ));
  }
}
