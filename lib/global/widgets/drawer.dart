import 'package:flutter/material.dart';

class MyDrawer {
  static getDrawerWidget(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 20,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
                left: BorderSide(color: Colors.white),
                right: BorderSide(color: Colors.white)),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                topRight: Radius.circular(50)),
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: ListView.builder(
          itemCount: 1000,
          itemBuilder: (context, index) {
            return ListTile(
              textColor: Colors.white,
              title: Text("Hello ${index + 1}"),
            );
          },
        ),
      ),
    );
  }
}
