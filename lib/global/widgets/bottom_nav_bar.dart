import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pecockapp/global/utils/utils.dart';

class BottomNavBarWidget {
  static bottomNavBar(
      BuildContext context, int currentPageIndexValue, Function(int)? e) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white),
              left: BorderSide(color: Colors.white),
              right: BorderSide(color: Colors.white)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.deepOrange,
        elevation: 10,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        iconSize: context.screenHeight * 0.035,
        currentIndex: currentPageIndexValue,
        onTap: e,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(
              CupertinoIcons.person_3_fill,
            ),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(
              Icons.business,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
