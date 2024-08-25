// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/global/widgets/form_widgets.dart';
import 'package:pecockapp/modules/login/bloc/login_bloc.dart';
import 'package:pecockapp/modules/login/bloc/login_event.dart';
import 'package:pecockapp/modules/login/bloc/login_state.dart';

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
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FormWidget.textFieldFormWidget(context,
                      enabled: true,
                      controller: usernameController,
                      normalIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      labelText: "Username/E-Mail",
                      errorText: (state is LoginFormInvalidState)
                          ? state.usernameError
                          : null, onChanged: (value) {
                    BlocProvider.of<LoginBloc>(context).add(
                        LoginTextChangedEvent(
                            usernameText: usernameController.text,
                            passwordText: passwordController.text));
                  }, inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9.@]'))
                  ]),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FormWidget.textFieldFormWidget(context,
                      enabled: true,
                      obscureText: !showPassword,
                      obscuringCharacter: '#',
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      labelText: "Password",
                      normalIcon: Icons.lock_clock, onChanged: (value) {
                    BlocProvider.of<LoginBloc>(context).add(
                        LoginTextChangedEvent(
                            usernameText: usernameController.text,
                            passwordText: passwordController.text));
                  },
                      errorText: (state is LoginFormInvalidState)
                          ? state.passwordError
                          : null,
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
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9.@]'))
                      ]),
                ),
                (state is LoginFormValidState)
                    ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                          width: context.screenWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                 BlocProvider.of<LoginBloc>(context).add(
                              LoginFormSubmitEvent(
                                  usernameData: usernameController.text,
                                  passwordData: passwordController.text));
                              },
                              child: const Text("Login"))),
                    )
                    : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                          width: context.screenWidth,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey),
                              onPressed: () {
                                 BlocProvider.of<LoginBloc>(context).add(
                              LoginTextChangedEvent(
                                  usernameText: usernameController.text,
                                  passwordText: passwordController.text));
                              },
                              child: const Text("Login"))),
                    ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                      width: context.screenWidth,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text("Register Here"))),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
