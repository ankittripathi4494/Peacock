import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';

class AutoScheduleTaskWidget {
  static taskScheduler(BuildContext context,
      {required Function() task,
      required Duration taskWaitDuration,
      Widget? childWidget}) {
    return DurationButton(
      width: 1,
      height: 1,
      backgroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      coverColor: Colors.transparent,
      onPressed: () {}, //execute when user click on button
      onComplete: task, //execute when duration completes
      duration: taskWaitDuration,
      child: childWidget,
    );
  }

  static taskSchedulerWithSize(BuildContext context,
      {required Function() task,
      required Duration taskWaitDuration,
      Widget? childWidget,
      double? width,
      double? height}) {
    return DurationButton(
      width: width,
      height: height,
      backgroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      coverColor: Colors.transparent,
      onPressed: () {}, //execute when user click on button
      onComplete: task, //execute when duration completes
      duration: taskWaitDuration,
      child: childWidget,
    );
  }
}
