// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/widgets/app_bar_widget.dart';
import 'package:pecockapp/modules/customer/widgets/edit_customer_widget.dart';

class EditCustomerScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  EditCustomerScreen({
    super.key,
    required this.argus,
  });

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  int screenNumber = 1;
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
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarWidget.appBarWidgetMethod(context,
              title: const Text(
                "Edit Customer",
                style: TextStyle(color: Colors.white),
              )),
          body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: EditCustomerWidget(
                argus: widget.argus,
              )),
        ),
      ),
    );
  }
}
