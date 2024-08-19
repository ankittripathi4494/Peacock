// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/widgets/dialog.dart';
import 'package:pecockapp/modules/login/widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  LoginScreen({
    super.key,
    this.argus,
  });

  @override
  State<LoginScreen> createState() => _LoginScreen(); // State class
}

// private class
class _LoginScreen extends State<LoginScreen> {
  bool selectedData = false;
  @override
  Widget build(BuildContext context) {
    // Scaffold represents a screen or page
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          Timer(Durations.medium4, () {
            Navigator.pushReplacementNamed(context, '/internet-disconnect');
          });
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Switch(
                    value: selectedData,
                    onChanged: (value) {
                      if (selectedData == true) {
                        CustomAlertDialog.showCustomDialogForGeneral(context,
                            icon: const Icon(
                              Icons.notification_important,
                              size: 30,
                              color: Colors.deepOrange,
                            ),
                            title: const Text(
                              "Do you want disable this?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  print("selectedData:- $selectedData");
                                  setState(() {
                                    selectedData = false;
                                  });
                                  Navigator.pop(context);

                                  print("selectedData:- $selectedData");
                                },
                                label: const Text("Yes"),
                                icon: const Icon(Icons.check_circle),
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: const Text("No"),
                                icon: const Icon(Icons.cancel_rounded),
                              ),
                            ]);
                      } else {
                        CustomAlertDialog.showCustomDialogForGeneral(context,
                            icon: const Icon(
                              Icons.notification_important,
                              size: 30,
                              color: Colors.deepOrange,
                            ),
                            title: const Text(
                              "Do you want enable this?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  print("selectedData:- $selectedData");
                                  setState(() {
                                    selectedData = true;
                                  });
                                  Navigator.pop(context);

                                  print("selectedData:- $selectedData");
                                },
                                label: const Text("Yes"),
                                icon: const Icon(Icons.check_circle),
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: const Text("No"),
                                icon: const Icon(Icons.cancel_rounded),
                              ),
                            ]);
                      }
                    },
                  );
                }),
                const LoginWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
