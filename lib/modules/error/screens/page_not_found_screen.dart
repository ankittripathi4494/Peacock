// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import '../widgets/page_not_found_widget.dart';

class PageNotFoundScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  PageNotFoundScreen({
    super.key,
    this.argus,
  });

  @override
  State<PageNotFoundScreen> createState() => _PageNotFoundScreen(); // State class
}

// private class
class _PageNotFoundScreen extends State<PageNotFoundScreen> {
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
          child: PageNotFoundWidget(),
        ),
      ),
    );
  }
}
