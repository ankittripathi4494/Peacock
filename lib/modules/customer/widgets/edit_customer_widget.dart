// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_dropdown_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_radio_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_text_form_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
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
                items:
                     marriageStatusList,
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
            prefix: const Icon(Icons.calendar_month,size: 50, color: Colors.white,),
              controller: customerDobController,
              enabled: false,
              labelText: "Select DOB",
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
  }
}
