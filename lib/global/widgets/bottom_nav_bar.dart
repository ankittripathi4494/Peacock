
import 'package:flutter/material.dart';
import 'package:pecockapp/global/utils/utils.dart';

class BottomNavBarWidget {
  static BottomNavigationBar bottomNavBar(BuildContext context,
      int currentPageIndexValue, Function(int)? e) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: const Color.fromARGB(255, 122, 121, 121),
      selectedItemColor: Colors.blue,
      showSelectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      iconSize: context.screenHeight * 0.035,
      currentIndex: currentPageIndexValue,
      onTap: e,
      // BottomNavigationBarItem(
        //   backgroundColor: Colors.white,
        //   icon: Icon(
        //     Icons.record_voice_over,
        //   ),
        //   label: 'Invoices',
        // ),
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.list,
          ),
          label: 'Customers',
        ),
        
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.business,
          ),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.person_2_outlined,
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
