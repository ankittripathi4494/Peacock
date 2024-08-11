// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';

class InternetNotFoundWidget extends StatefulWidget {
  const InternetNotFoundWidget({
    super.key,
  });

  @override
  State<InternetNotFoundWidget> createState() => _InternetNotFoundWidgetState();
}

class _InternetNotFoundWidgetState extends State<InternetNotFoundWidget> {
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
      child: const Text(
        "Internet not found Screen",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
