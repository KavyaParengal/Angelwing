
import 'package:demo1/homepage.dart';
import 'package:demo1/notification.dart';
import 'package:demo1/orphan_list.dart';
import 'package:demo1/profile.dart';
import 'package:demo1/single_orphanage.dart';
import 'package:flutter/material.dart';

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatioPageName.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
    int _selectedIndex = 0;
    List navigatioPageName = [
      HomePage(),
      ClassNotify(),
      Profile(),
    ];
    void onItemTapped(int index){
      setState(() {
        _selectedIndex = index;
      });

  }
}
