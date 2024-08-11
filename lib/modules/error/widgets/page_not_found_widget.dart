// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';

class PageNotFoundWidget extends StatefulWidget {
  const PageNotFoundWidget({
    super.key,
  });

  @override
  State<PageNotFoundWidget> createState() => _PageNotFoundWidgetState();
}

class _PageNotFoundWidgetState extends State<PageNotFoundWidget> {
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
        "Page not found Screen",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
