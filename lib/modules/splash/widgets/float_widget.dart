import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';

class FloattingPointWidget extends StatelessWidget {
  const FloattingPointWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisSize: MainAxisSize.min,
      children: [
        const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        DurationButton(
          width: 1,
          height: 1,
          backgroundColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          coverColor: Colors.transparent,
          onPressed: () {}, //execute when user click on button
          onComplete: () {
            Navigator.pushNamed(context, '/login');
          }, //execute when duration completes
          duration: const Duration(seconds: 5),
          child: Container(),
        ),
      ],
    );
  }
}
