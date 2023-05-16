// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:agri_well/constants.dart';
import 'package:agri_well/register_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  User? user;

  getUser() {
    try {
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      //
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kWhiteColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.2,
              backgroundColor: kWhiteColor,
              title: Text(
                'Account',
                style: TextStyle(color: kTextColor),
              ),
              leading: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kTextColor,
                  )),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.r),
                        child: CachedNetworkImage(
                          imageUrl: user!.photoURL!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  user!.displayName!,
                  style: kTextStyle.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return Container(
                            height: 150.h,
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Do you want to logout?',
                                      style:
                                          kTextStyle.copyWith(fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            GoogleSignIn googleSignin =
                                                GoogleSignIn();
                                            googleSignin.disconnect();

                                            Navigator.pushAndRemoveUntil(
                                                context, MaterialPageRoute(
                                                    builder: (builder) {
                                              return const MobileRegistrationScreen();
                                            }), (route) => false);
                                          } catch (e) {
                                            //
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: kGreenColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Text(
                                            'Logout',
                                            style: kTextStyle.copyWith(
                                                color: kWhiteColor,
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    height: 60.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kGreenColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                ),
              ],
            )));
  }
}
