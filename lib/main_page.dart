// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agri_well/chat_screen.dart';
import 'package:agri_well/constants.dart';
import 'package:agri_well/history_screen.dart';
import 'package:agri_well/home_screen.dart';
import 'package:agri_well/info_screen.dart';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> listOfScreens = [
    HomeScreen(),
    HistoryScreen(),
    ChatScreen(),
    InfoScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xffe1e6ec),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;

              // if (index == 2) {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (builder) {
              //     return ChatScreen();
              //   }));
              // }
            });
          },
          selectedItemColor: kGreenColor,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          backgroundColor: kWhiteColor,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Community'),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline), label: 'About'),
          ],
        ),
        body: IndexedStack(
          index: index,
          children: listOfScreens,
        ),
      ),
    );
  }
}
