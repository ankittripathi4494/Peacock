// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:pecockapp/modules/splash/widgets/splash_image.dart';

class SplashScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  SplashScreen({
    super.key,
    this.argus,
  });

  @override
  State<SplashScreen> createState() => _SplashScreen(); // State class
}

// private class
class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold represents a screen or page
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SplashImage(widget: widget),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepOrange),
          label: const Text("Click here to redirect"),
          icon: const Icon(Icons.ads_click),
        ),
      ),
    );
  }
}
