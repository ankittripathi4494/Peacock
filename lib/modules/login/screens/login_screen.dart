// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
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
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: LoginWidget(),
          ),
        ),
      ),
    );
  }
}
