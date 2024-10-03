// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/utils/firebase_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/widgets/toast.dart';
import 'package:pecockapp/modules/register/widgets/register_widget.dart';

class RegisterScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  RegisterScreen({
    super.key,
    this.argus,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreen(); // State class
}

// private class
class _RegisterScreen extends State<RegisterScreen> {
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
          body: const Center(
            child: RegisterWidget(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              FirebaseHelper.firebaseAuth
                  .signInWithProvider(GoogleAuthProvider())
                  .then((c) {
                LoggerUtil().errorData("Success Sign Up :- ${c.user}");
                ToastedNotification.successToast(context,
                    description: "Login Successfull");
                Navigator.pushReplacementNamed(context, '/login');
              }).onError((e, k) {
                LoggerUtil().errorData("Error Sign Up :- ${e.toString()}");
                ToastedNotification.errorToast(context,
                    description: "Error Sign Up :- ${e.toString()}");
                Navigator.pushReplacementNamed(context, '/register');
              });
            },
            label: const Text("Sign Up with Google"),
            icon: const Icon(FontAwesomeIcons.google),
          ),
        ),
      ),
    );
  }
}
