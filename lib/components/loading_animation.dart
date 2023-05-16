// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:agri_well/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  int percentage = 0;

  bool check = true;

  void getPercentage() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));

      setState(() {
        percentage = i;
        if (percentage == 100) {
          check = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPercentage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Predicting',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: kTextColor,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Running AI Model on the  image',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(
                  0xFFC8CEC6,
                ),
              ),
            ),
            LottieBuilder.asset(
              'assets/leaf_scan_animation.json',
              // fit: BoxFit.fill,
              width: 500.w,
              height: 500.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  check ? 'Processing...' : 'Getting Results please wait...',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xFFC8CEC6,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
