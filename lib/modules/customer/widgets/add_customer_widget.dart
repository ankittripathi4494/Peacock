// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_dropdown_form_widget.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_text_form_widget.dart';

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
  Map<String, dynamic>? selectedGender;
  Map<String, dynamic>? selectedMarriageStatus;
  bool changedMarriageStatus = false;
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
                    changedMarriageStatus = true;
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
            subtitle: CustomDropdown(
                items:
                    (changedMarriageStatus == false) ? [] : marriageStatusList,
                hint: "Select Marriage Status",
                selectedValue: selectedMarriageStatus,
                onChanged: (value) {
                  setState(() {
                    selectedMarriageStatus = value;
                  });
                },
                getTitle: (item) => item['title']),
          ),
        ),
      ],
    ));
  }
}
