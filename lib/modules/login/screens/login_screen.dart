// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // Scaffold represents a screen or page
    return Container(
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
    );
  }
}
