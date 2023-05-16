// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_field, use_build_context_synchronously

import 'package:agri_well/data/symptoms.dart';
import 'package:agri_well/main_page.dart';
import 'package:agri_well/utility_classes/delete_image_database.dart';
import 'package:agri_well/utility_classes/format_time.dart';
import 'package:agri_well/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'data/treatment.dart';

class DetailScreen extends StatefulWidget {
  final double confidence;
  final String imageUrl;
  final String plantName;
  final DateTime time;
  final String disease;
  final String docId;
  final bool isFromResultScreen;

  bool loadShimmer = false;
  User? user;
  DetailScreen(
      {super.key,
      required this.disease,
      required this.confidence,
      required this.imageUrl,
      required this.plantName,
      required this.time,
      required this.user,
      required this.docId,
      required this.isFromResultScreen});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late List<Text> listOfFetchedData;

  Map<String, String> treatmentMap = Treatment.Apple;
  Map<String, List<String>> symptomMap = Symptoms.Apple;
  List<String> listOfSymptoms = [];

  List<CutomSymptomTextWidget> getSymptoms() {
    List<CutomSymptomTextWidget> listOfSymptomWidget = [];
    if (listOfSymptoms.isNotEmpty) {
      for (int index = 0; index < listOfSymptoms.length; index++) {
        listOfSymptomWidget.add(CutomSymptomTextWidget(
            symptom: '${index + 1})${listOfSymptoms[index]}'));
      }
    } else {
      listOfSymptomWidget.add(CutomSymptomTextWidget(symptom: 'Healthy'));
    }

    return listOfSymptomWidget;
  }

  void getPlantMap() {
    switch (widget.plantName) {
      case 'Apple':
        treatmentMap = Treatment.Apple;
        symptomMap = Symptoms.Apple;
        break;
      case 'BellPepper':
        treatmentMap = Treatment.BellPepper;
        symptomMap = Symptoms.BellPepper;
        break;
      case 'Cherry':
        treatmentMap = Treatment.Cherry;
        symptomMap = Symptoms.Cherry;
        break;
      case 'Corn':
        treatmentMap = Treatment.Corn;
        symptomMap = Symptoms.Corn;
        break;
      case 'Grape':
        treatmentMap = Treatment.Grape;
        symptomMap = Symptoms.Grape;
        break;
      case 'Peach':
        treatmentMap = Treatment.Peach;
        symptomMap = Symptoms.Peach;
        break;
      case 'Potato':
        treatmentMap = Treatment.Potato;
        symptomMap = Symptoms.Potato;
        break;
      case 'Rice':
        treatmentMap = Treatment.Rice;
        symptomMap = Symptoms.Rice;
        break;
      case 'Tomato':
        treatmentMap = Treatment.Tomato;
        symptomMap = Symptoms.Tomato;
        break;
    }

    if (symptomMap[widget.disease] != null) {
      listOfSymptoms = symptomMap[widget.disease]!;
    }
  }

  String getTreatment() {
    if (widget.disease == 'Healthy') {
      return 'Hurray, your Plant is Healthy';
    }
    String? treatment;

    treatment = treatmentMap[widget.disease];

    if (treatment == null) {
      return 'No Data Available';
    }
    return treatment;
  }

  Widget getAttentionCard() {
    if (widget.disease == 'Healthy') {
      return Text('');
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffFFE4B3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Atterntion',
        style: TextStyle(color: Colors.orange, fontSize: 12.sp),
      ),
    );
  }

  late final FirebaseFirestore? _firestore;
  late final User? user;

  void getUser() {
    try {
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      //
    }
  }

  @override
  void initState() {
    getPlantMap();
    _firestore = FirebaseFirestore.instance;
    getUser();

    super.initState();
  }

  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    // print(treatment['Apple Scab']);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          actions: [
            !widget.isFromResultScreen
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () async {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delete this Prediction?',
                                          style: kTextStyle.copyWith(
                                              fontSize: 15.sp),
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
                                                await _firestore!
                                                    .collection('user_data')
                                                    .doc(user!.uid)
                                                    .collection('predictions')
                                                    .doc(widget.docId)
                                                    .delete();

                                                await DeleteImageFromDataBase()
                                                    .deleteImageFromDB(
                                                        widget.imageUrl);

                                                Navigator.pushAndRemoveUntil(
                                                    context, MaterialPageRoute(
                                                        builder: (builder) {
                                                  return MainPage();
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
                                                      BorderRadius.circular(
                                                          10.r)),
                                              child: Text(
                                                'Delete',
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
                      icon: Icon(
                        FontAwesomeIcons.solidTrashCan,
                        color: kTextColor,
                        size: 23.h,
                      ),
                    ),
                  )
                : Text(''),
          ],
          elevation: 0,
          backgroundColor: kWhiteColor,
          leading: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kTextColor,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 250.h,
                              decoration: BoxDecoration(),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.imageUrl,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        getAttentionCard(),
                                  )),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  // color: Colors.amber,
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.disease,
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500,
                                              color: kTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(left: 8.w),
                                      height: 8.h,
                                      width: 8.h,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      TimeFormatter.formatDate(widget.time),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: kLightColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getAttentionCard(),
                                // SizedBox(
                                //   width: 5.w,
                                // ),
                                // Icon(Icons.more_vert),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        widget.disease != 'Healthy'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.w,
                                        top: 15.h,
                                        bottom: 15.h,
                                        right: 4.w),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE9F1FE),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Color(0xff414C81),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Please check the symptoms below with your plants condition before treating ',
                                            style: TextStyle(
                                                color: Color(0xff414C81),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.bookMedical),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Symptoms',
                                        style: TextStyle(
                                            color: kLightColor2,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Column(
                                    children: getSymptoms(),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.syringe),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Treatment',
                                        style: TextStyle(
                                            color: kLightColor2,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 23.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CutomSymptomTextWidget(
                                    symptom: getTreatment(),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.fileMedical),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Recommendation',
                                        style: TextStyle(
                                            color: kLightColor2,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 23.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CutomSymptomTextWidget(
                                      symptom:
                                          'In the early stages of a disease or when the crop is about to be harvested, we advise using organic control methods. Please abide by chemical control measures when a disease is more advanced. It is not advised to combine or use several things at once.'),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Lottie.asset('assets/healthy.json',
                                      height: 150.h),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                      child: Text(
                                    'Hurray, your plant is Healthy!',
                                    style: TextStyle(fontSize: 20.sp),
                                  )),
                                ],
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CutomSymptomTextWidget extends StatelessWidget {
  final String symptom;
  const CutomSymptomTextWidget({
    super.key,
    required this.symptom,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      symptom,
      style: TextStyle(
          color: kLightColor2, fontSize: 15.sp, fontWeight: FontWeight.w400),
    );
  }
}

class MidTextWidget extends StatelessWidget {
  final String head;
  final String bottom;

  const MidTextWidget({super.key, required this.head, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: TextStyle(color: kLightColor1, fontSize: 15.sp),
        ),
        Text(
          bottom,
          style: TextStyle(
              color: kLightColor2,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
