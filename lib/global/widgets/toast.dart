import 'package:flutter/material.dart';

class ToastedNotification {
  static successToast(BuildContext context,
      {String? title,
      required String? description,
      Function()? actionTask,
      bool? isActionExist,
      String? actionName}) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            duration: Durations.extralong4,
            content: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(0),
              visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
              style: ListTileStyle.list,
              titleTextStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              subtitleTextStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              leading: const Icon(
                Icons.check_circle,
                size: 30,
                color: Colors.white,
              ),
              title: Text((title != null) ? title : "Success"),
              subtitle: Text((description != null) ? description : ""),
              trailing: (isActionExist == true)
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white)),
                      onPressed: actionTask,
                      child: Text(actionName ?? ''))
                  : const SizedBox.shrink(),
            )),
        snackBarAnimationStyle: AnimationStyle(curve: Curves.bounceInOut));
  }

  static errorToast(BuildContext context,
      {String? title,
      required String? description,
      Function()? actionTask,
      bool? isActionExist,
      String? actionName}) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            duration: Durations.extralong4,
            content: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(0),
              visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
              style: ListTileStyle.list,
              titleTextStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              subtitleTextStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              leading: const Icon(
                Icons.cancel_rounded,
                size: 30,
                color: Colors.white,
              ),
              title: Text((title != null) ? title : "Error"),
              subtitle: Text((description != null) ? description : ""),
              trailing: (isActionExist == true)
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white)),
                      onPressed: actionTask,
                      child: Text(actionName ?? ''))
                  : const SizedBox.shrink(),
            )),
        snackBarAnimationStyle: AnimationStyle(curve: Curves.bounceInOut));
  }
}
