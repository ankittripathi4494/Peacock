import 'package:flutter/material.dart';

class CustomAlertDialog {
  static showCustomDialogForGeneral(BuildContext context,
      {Widget? icon, Widget? title, Widget? content, List<Widget>? actions}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: (icon != null) ? icon : null,
        title: (title != null) ? title : null,
        content: (content != null) ? content : null,
        actions: (actions != null) ? actions : [],
        actionsAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
