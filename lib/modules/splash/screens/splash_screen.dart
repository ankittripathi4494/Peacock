// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/utils/shared_preferences_helper.dart';
import 'package:pecockapp/modules/splash/widgets/float_widget.dart';
import 'package:pecockapp/modules/splash/widgets/splash_image.dart';

class SplashScreen extends StatelessWidget {
  late Map<String, dynamic>? argus;
  SplashScreen({
    super.key,
    this.argus,
  });
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  @override
  Widget build(BuildContext context) {
    // Scaffold represents a screen or page
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          if ((sph.containsKey("isLoggedIn")!) &&
              (sph.getBool("isLoggedIn") == true)) {
            Timer(Durations.long3, () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            });
          } else {
            Timer(Durations.long3, () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            });
          }
        } else if (state == InternetState.internetLost) {
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
            child: SplashImage(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloattingPointWidget(),
        ),
      ),
    );
  }

  // State class
}
