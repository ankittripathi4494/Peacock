// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pecockapp/global/widgets/form_widgets.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
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
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FormWidget.textFieldFormWidget(context,
                  enabled: true,
                  controller: usernameController,
                  normalIcon: Icons.person,
                  keyboardType: TextInputType.name,
                  labelText: "Username/E-Mail",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9.@]'))
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FormWidget.textFieldFormWidget(context,
                  enabled: true,
                  obscureText: !showPassword,
                  obscuringCharacter: '#',
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  labelText: "Password",
                  normalIcon: Icons.lock_clock,
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
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9.@]'))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
