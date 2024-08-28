// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/widgets/bottom_nav_bar.dart';
import 'package:pecockapp/global/widgets/dialog.dart';
import 'package:pecockapp/global/widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  ProfileScreen({
    super.key,
    this.argus,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int screenNumber = 3;
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          Timer(Durations.medium4, () {
            Navigator.pushReplacementNamed(context, '/internet-disconnect');
          });
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            CustomAlertDialog.showCustomDialogForGeneral(context,
                title: const Text("Do you want to close app??"),
                actions: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      exit(0);
                    },
                    label: const Text("Yes"),
                    icon: const Icon(Icons.check_box_rounded),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text("No"),
                    icon: const Icon(Icons.cancel_rounded),
                  ),
                ]);
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
            appBar: AppBar(
               backgroundColor: Colors.transparent,
               systemOverlayStyle: SystemUiOverlayStyle.light,
               iconTheme: IconThemeData(color: Colors.white),
               actionsIconTheme: IconThemeData(color: Colors.white),
            ),
            drawer: MyDrawer.getDrawerWidget(context),
            body: Center(
              child: Text("Profile Screen"),
            ),
            bottomNavigationBar:
                BottomNavBarWidget.bottomNavBar(context, screenNumber, (d) {
              setState(() {
                screenNumber = d;
              });
              if (screenNumber == 0) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              } else if (screenNumber == 1) {
                Navigator.pushReplacementNamed(context, '/customer-list');
              } else if (screenNumber == 2) {
                Navigator.pushReplacementNamed(context, '/business');
              } else if (screenNumber == 3) {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            }),
          ),
        ),
      ),
    );
  }
}
