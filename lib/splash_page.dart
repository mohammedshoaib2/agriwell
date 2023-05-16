// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:agri_well/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main_page.dart';
import 'register_screen.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'SplashPage';
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void callHomeScreen() async {
    // bool isUserRegistered = false;
    bool isUserRegistered = await getVisitingFlag();
    // print(isUserRegistered);
    Timer(Duration(seconds: 5), () {
      if (isUserRegistered && FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MainPage();
        }));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MobileRegistrationScreen();
        }));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    callHomeScreen();
  }

  // Color backgroundColor = const Color(0xffe9edf1);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      systemNavigationBarColor: backgroundColor,
    ));

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SvgPicture.asset(
            'assets/LogoSvg.svg',
            height: 80,
          ),
          Spacer(),
          Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Color(0xff2d5765),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Made with ❤️ by Students of ISL',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
