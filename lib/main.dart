// ignore_for_file: prefer_const_constructors

import 'package:agri_well/constants.dart';

import 'package:agri_well/splash_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'splash_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          title: 'AgriWell',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // useMaterial3: true,
            canvasColor: Colors.transparent,
            primaryColor: kGreenColor,
            fontFamily: 'Poppins',
          ),
          // home: MobileRegistrationScreen(),
          home: SplashPage(),
        );
      },
    );
  }
}
