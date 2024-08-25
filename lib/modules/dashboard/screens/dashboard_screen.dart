// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/widgets/dialog.dart';

class DashboardScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  DashboardScreen({
    super.key,
    this.argus,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                title: Text("Do you want to close app??"),
                actions: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      exit(0);
                    },
                    label: Text("Yes"),
                    icon: Icon(Icons.check_box_rounded),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text("No"),
                    icon: Icon(Icons.cancel_rounded),
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
          child: const Scaffold(
            body: Center(
              child: Text("Dashboard Screen"),
            ),
          ),
        ),
      ),
    );
  }
}
