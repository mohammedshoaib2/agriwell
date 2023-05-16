// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:agri_well/constants.dart';
import 'package:agri_well/main_page.dart';
import 'package:agri_well/utility_classes/google_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class MobileRegistrationScreen extends StatefulWidget {
  const MobileRegistrationScreen({super.key});

  @override
  State<MobileRegistrationScreen> createState() =>
      _MobileRegistrationScreenState();
}

class _MobileRegistrationScreenState extends State<MobileRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kWhiteColor,
      body: Padding(
        padding:
            EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w, bottom: 30.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/LogoSvg.svg',
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  LottieBuilder.asset('assets/no_data_new.json'),
                  Text(
                    'Managing Plants\nis now easy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Take care of your Plant\nusing our application',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await GoogleSignin.signInWithGoogle();
                        setVisitingFlag();

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (builder) {
                          return MainPage();
                        }), (route) => false);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Something went wrong')));
                      }
                    },
                    child: Container(
                      // margin: EdgeInsets.symmetric(),
                      alignment: Alignment.center,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: kGreenColor, width: 1.5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/google-icon.svg',
                              height: 35.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kGreenColor,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By proceeding, I accept the AgriWell ',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      Text(
                        'Privacy policy',
                        style: TextStyle(fontSize: 11.sp, color: kGreenColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
