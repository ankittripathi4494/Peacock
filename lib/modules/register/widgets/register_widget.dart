// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/firebase_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/auto_schedule_task.dart';
import 'package:pecockapp/global/widgets/form_widgtes/custom_text_form_widget.dart';
import 'package:pecockapp/global/widgets/toast.dart';
import 'package:pecockapp/modules/register/bloc/register_bloc.dart';
import 'package:pecockapp/modules/register/bloc/register_event.dart';
import 'package:pecockapp/modules/register/bloc/register_state.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({
    super.key,
  });

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  Map<String, dynamic>? selectedGender;
  Map<String, dynamic>? selectedMarriageStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          border: Border.all(color: Colors.transparent, width: 2),
          gradient: const LinearGradient(
              colors: [Colors.transparent, Colors.transparent],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                (state is RegisterFormSubmitSuccessState)
                    ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                        FirebaseHelper.firebaseAnalytics
                            .logLogin(
                                loginMethod: 'resgister',
                                parameters: {
                                  'username': usernameController.text
                                },
                                callOptions: AnalyticsCallOptions(global: true))
                            .then((c) {
                          Navigator.pushReplacementNamed(context, '/login');

                          ToastedNotification.successToast(context,
                              description: state.successMessage);
                        }).onError((c, k) {
                          LoggerUtil().errorData(c.toString());
                        });
                      }, taskWaitDuration: Durations.short4)
                    : const SizedBox.shrink(),
                (state is RegisterFormSubmitFailedState)
                    ? AutoScheduleTaskWidget.taskScheduler(context, task: () {
                        Navigator.pushReplacementNamed(context, '/register');
                        ToastedNotification.errorToast(context,
                            description: state.failedMessage);
                      }, taskWaitDuration: Durations.short4)
                    : const SizedBox.shrink(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextFormField(
                      enabled: true,
                      controller: usernameController,
                      normalIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      labelText: "Username/E-Mail",
                      errorText: (state is RegisterFormInvalidState)
                          ? state.usernameError
                          : null,
                      onChanged: (p0) {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterTextChangedEvent(
                                usernameText: usernameController.text,
                                passwordText: passwordController.text,
                                confirmPasswordText:
                                    confirmPasswordController.text,
                                selectedGender: selectedGender,
                                selectedMarriageStatus:
                                    selectedMarriageStatus));
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9.@]'))
                      ]),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextFormField(
                      enabled: true,
                      obscureText: !showPassword,
                      obscuringCharacter: '#',
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      labelText: "Password",
                      errorText: (state is RegisterFormInvalidState)
                          ? state.passwordError
                          : null,
                      normalIcon: Icons.lock_clock,
                      onChanged: (p0) {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterTextChangedEvent(
                                usernameText: usernameController.text,
                                passwordText: passwordController.text,
                                confirmPasswordText:
                                    confirmPasswordController.text,
                                selectedGender: selectedGender,
                                selectedMarriageStatus:
                                    selectedMarriageStatus));
                      },
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          (showPassword == false)
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9.@]'))
                      ]),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextFormField(
                      enabled: true,
                      obscureText: !showConfirmPassword,
                      obscuringCharacter: '#',
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      labelText: "Confirm Password",
                      errorText: (state is RegisterFormInvalidState)
                          ? state.confirmPasswordError
                          : null,
                      normalIcon: Icons.lock_clock,
                      onChanged: (p0) {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterTextChangedEvent(
                                usernameText: usernameController.text,
                                passwordText: passwordController.text,
                                confirmPasswordText:
                                    confirmPasswordController.text,
                                selectedGender: selectedGender,
                                selectedMarriageStatus:
                                    selectedMarriageStatus));
                      },
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                        child: Icon(
                          (showConfirmPassword == false)
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9.@]'))
                      ]),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DropdownButtonFormField2<Map<String, dynamic>>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      errorText: (state is RegisterFormInvalidState)
                          ? state.genderError
                          : null,
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Add more decoration..
                    ),
                    hint: const Text(
                      'Select Your Gender',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    items: genderList
                        .map((item) => DropdownMenuItem<Map<String, dynamic>>(
                              value: item,
                              child: Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when selected item is changed.
                      setState(() {
                        selectedGender = value;
                      });
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterTextChangedEvent(
                              usernameText: usernameController.text,
                              passwordText: passwordController.text,
                              confirmPasswordText:
                                  confirmPasswordController.text,
                              selectedGender: selectedGender,
                              selectedMarriageStatus: selectedMarriageStatus));
                    },
                    onSaved: (value) {},
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: marriageStatusList
                            .map((c) => RadioMenuButton<Map<String, dynamic>>(
                                value: c,
                                groupValue: selectedMarriageStatus,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMarriageStatus = value;
                                  });
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      RegisterTextChangedEvent(
                                          usernameText: usernameController.text,
                                          passwordText: passwordController.text,
                                          confirmPasswordText:
                                              confirmPasswordController.text,
                                          selectedGender: selectedGender,
                                          selectedMarriageStatus:
                                              selectedMarriageStatus));
                                },
                                child: Text(c['title'])))
                            .toList(),
                      )),
                ),
                (state is RegisterFormValidState)
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SizedBox(
                            width: context.screenWidth,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      RegisterFormSubmitEvent(
                                          usernameData: usernameController.text,
                                          passwordData: passwordController.text,
                                          confirmPasswordData:
                                              confirmPasswordController.text,
                                          selectedGender: selectedGender,
                                          selectedMarriageStatus:
                                              selectedMarriageStatus));
                                },
                                child: const Text("Register"))),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SizedBox(
                            width: context.screenWidth,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.grey),
                                onPressed: () {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      RegisterTextChangedEvent(
                                          usernameText: usernameController.text,
                                          passwordText: passwordController.text,
                                          confirmPasswordText:
                                              confirmPasswordController.text,
                                          selectedGender: selectedGender,
                                          selectedMarriageStatus:
                                              selectedMarriageStatus));
                                },
                                child: const Text("Register"))),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                      width: context.screenWidth,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text("Login Here"))),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
