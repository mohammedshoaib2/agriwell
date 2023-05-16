// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

Color backgroundColor = const Color(0xffffffff);
Color secondaryColor = const Color(0xffe1e6ec);
Color accentColor = const Color(0xff2d5765);
Color kGreenColor = const Color(0xFF036C37);
Color kDarkGreen = const Color(0xFF18565F);
Color kLightColor = const Color(0xFFC8CEC6);
Color kLightColor1 = const Color(0xFFBDBBBE);
Color kLightColor2 = const Color(0xFF5C5261);
Color kWhiteColor = const Color(0xFFFFFFFF);
Color kRoundedContainerColor = const Color(0xFFF8F8F8);
Color kGreenNormal = Colors.green;
Color kRedNormal = Colors.red;
Color kOrangeNormal = Colors.orange;

Color kTextColor = Color(0xFF141315);
TextStyle kTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 30.sp,
  fontWeight: FontWeight.w500,
  color: Color(
    0xFF141315,
  ),
);

const String shoaibProfileUrl =
    'https://firebasestorage.googleapis.com/v0/b/agriwell-6ce03.appspot.com/o/profile%2Fshoaib_profile.jpeg?alt=media&token=e8815857-ab91-44be-8d6c-1f46a665e98b';
const String faisalProfileUrl =
    'https://firebasestorage.googleapis.com/v0/b/agriwell-6ce03.appspot.com/o/profile%2Ffaisal_profile.jpeg?alt=media&token=193f53a9-9a3f-465c-bf29-57ed60600cd8';
const String azharProfilrUrl =
    'https://firebasestorage.googleapis.com/v0/b/agriwell-6ce03.appspot.com/o/profile%2FWhatsApp%20Image%202023-05-05%20at%201.05.51%20PM.jpeg?alt=media&token=b3a79d5e-f8c0-4f4d-91c3-e96d22b96f33';
const List<String> officialMails = ['thismohdshoaib@gmail.com'];

setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setBool('alreadyVisited', true);
}

getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? flag = preferences.getBool('alreadyVisited') ?? false;
  return flag;
}

Shimmer getShimmerLoading(
    {required int height, required int width, required double radiius}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiius),
        color: Colors.white,
      ),
    ),
  );
}
