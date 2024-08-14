// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/modules/error/widgets/internet_not_found_widget.dart';

class InternetNotFoundScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  InternetNotFoundScreen({
    super.key,
    this.argus,
  });

  @override
  State<InternetNotFoundScreen> createState() =>
      _InternetNotFoundScreen(); // State class
}

// private class
class _InternetNotFoundScreen extends State<InternetNotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold represents a screen or page
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          Timer(Durations.medium4, () {
            Navigator.pushReplacementNamed(context, '/');
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
            child: InternetNotFoundWidget(),
          ),
        ),
      ),
    );
  }
}
