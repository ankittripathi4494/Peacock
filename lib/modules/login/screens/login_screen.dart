// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/blocs/internet/internet_state.dart';
import 'package:pecockapp/global/utils/firebase_helper.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/global/utils/shared_preferences_helper.dart';
import 'package:pecockapp/global/widgets/toast.dart';
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
  SharedPreferencesHelper sph = SharedPreferencesHelper();
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
            child: LoginWidget(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              try {
                final GoogleSignInAccount? googleUser =
                    await FirebaseHelper.googleSignIn.signIn();
                if (googleUser == null) return;

                final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;

                final AuthCredential credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );

                final UserCredential userCredential = await FirebaseHelper
                    .firebaseAuth
                    .signInWithCredential(credential);
                if (userCredential.user != null) {
                  // Log success message
                  LoggerUtil()
                      .errorData("Success Sign Up :- ${userCredential.user}");

                  // Save user session locally using SharedPreferences
                  sph.setBool("isLoggedIn", true);
                  sph.setString("username", userCredential.user?.email ?? '');
                  sph.setString("user", jsonEncode(userCredential.user));

                  // Show success toast
                  ToastedNotification.successToast(context,
                      description: "Login Successful");

                  // Navigate to dashboard after successful login
                  Navigator.pushReplacementNamed(context, '/dashboard');
                }
              } catch (e) {
                // Log error and show toast on failure
                LoggerUtil().errorData("Error Sign Up :- ${e.toString()}");
                ToastedNotification.errorToast(context,
                    description: "Error Sign Up :- ${e.toString()}");

                // Navigate back to login screen if sign-in fails
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            label: const Text("Login with Google"),
            icon: const Icon(FontAwesomeIcons.google),
          ),
        ),
      ),
    );
  }
}
