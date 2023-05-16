// ignore_for_file: prefer_const_constructors, unused_label, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_field, must_be_immutable, empty_catches, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:agri_well/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'utility_classes/format_time.dart';
import 'details.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late Widget listView;
  late Stream _stream;
  bool showShimmer = true;

  User? currentUser;

  void getCurrentUser() {
    try {
      currentUser = _auth.currentUser;
    } catch (e) {}
  }

  @override
  void initState() {
    getCurrentUser();

    _stream = FirebaseFirestore.instance
        .collection('user_data')
        .doc(currentUser!.uid)
        .collection('predictions')
        .orderBy('timestamp', descending: true)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kWhiteColor,
          elevation: 0.2,
          title: Text(
            'Your History',
            style: TextStyle(
              color: kTextColor,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataStream(currentUser: currentUser, stream: _stream),
          ],
        ));
  }
}

class DataStream extends StatelessWidget {
  DataStream({
    super.key,
    required this.currentUser,
    required this.stream,
  });

  final User? currentUser;
  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        List<CustomHistoryCardView> databaseCard = [];

        try {
          if (snapshot.hasData) {
            final fetchedDocuments = snapshot.data!.docs;

            int i = 0;

            for (var pair in fetchedDocuments) {
              var data = pair.data();
              // print(i);
              DocumentSnapshot documentSnapshot = fetchedDocuments[i];
              String docId = documentSnapshot.id;

              final confidence = data['confidence'];
              final imageUrl = data['imageurl'];
              final plantName = data['plant_name'];
              Timestamp time = data['timestamp'];
              final disease = data['disease'];

              DateTime dateTime = time.toDate();

              double convertedConfidence = double.parse(confidence);

              databaseCard.add(CustomHistoryCardView(
                disease: disease,
                confidence: convertedConfidence,
                imageUrl: imageUrl,
                plantName: plantName,
                time: dateTime,
                user: currentUser,
                docId: docId,
              ));

              i++;
            }

            return databaseCard.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Container(
                            height: 300.h,
                            width: 300.w,
                            child: Lottie.asset('assets/no_data_new.json')),
                        Text(
                          'YOU DONT HAVE ANY\nPREDICTIONS YET.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : Flexible(
                    child: ListView(
                      // clipBehavior: Clip.none,
                      physics: BouncingScrollPhysics(),
                      children: databaseCard,
                    ),
                  );
          }
        } catch (e) {}

        return Center(
          child: Text('No data'),
        );
      },
    );
  }
}

class CustomHistoryCardView extends StatelessWidget {
  final double confidence;
  final String imageUrl;
  final String plantName;
  final DateTime time;
  final String disease;
  final String docId;

  bool loadShimmer = false;
  User? user;
  // ignore: non_constant_identifier_names

  CustomHistoryCardView(
      {super.key,
      required this.disease,
      required this.confidence,
      required this.imageUrl,
      required this.plantName,
      required this.time,
      required this.user,
      required this.docId});

  Color whatColor() {
    if (confidence > 75) {
      return kGreenNormal;
    } else if (confidence > 50) {
      return kOrangeNormal;
    }
    return kRedNormal;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(
            imageUrl: imageUrl,
            confidence: confidence,
            disease: disease,
            docId: docId,
            plantName: plantName,
            time: time,
            user: user,
            isFromResultScreen: false,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        height: 150.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFEEEEEE),
              blurRadius: 44,
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(12.0),
              height: 140.h,
              width: 140.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      getShimmerLoading(height: 120, width: 120, radiius: 10),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          disease,
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/plant_icon.svg'),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      plantName,
                      style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/calender.svg'),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      TimeFormatter.formatDate(time),
                      style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                      decoration: BoxDecoration(
                          color: whatColor(),
                          borderRadius: BorderRadius.circular(100.r)),
                      child: Text(
                        // textAlign: TextAlign.center,
                        '$confidence%',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
