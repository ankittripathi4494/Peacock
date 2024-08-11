// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pecockapp/image_list.dart';
import 'package:pecockapp/modules/splash/screens/splash_screen.dart';
import 'package:pecockapp/utils.dart';

class SplashImage extends StatefulWidget {
  const SplashImage({
    super.key,
    required this.widget,
  });

  final SplashScreen widget;

  @override
  State<SplashImage> createState() => _SplashImageState();
}

class _SplashImageState extends State<SplashImage> {
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
      child: Image.asset(
        ImageList.splashLogo,
        width: context.screenHeight * 0.8,
        height: context.screenHeight * 0.8,
      ),
    );
  }
}
