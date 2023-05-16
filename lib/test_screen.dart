// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class DiseaseList extends StatefulWidget {
//   const DiseaseList({super.key});

//   @override
//   State<DiseaseList> createState() => _DiseaseListState();
// }

// final _firestore = FirebaseFirestore.instance;
// final _auth = FirebaseAuth.instance;

// class _DiseaseListState extends State<DiseaseList> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             StreamBuilder(
//                 stream: _firestore
//                     .collection('user_data')
//                     .doc(_auth.currentUser!.uid)
//                     .collection('predictions')
//                     .snapshots(),
//                 builder: (contex, snapshot) {
//                   List<Widget> textWidgets = [];

//                   if (snapshot.hasData) {
//                     final listDiseaseTexts = snapshot.data!.docs;
//                     // print(listDiseaseTexts.length);s

//                     for (var data in listDiseaseTexts) {
//                       final myVar = data.data();

//                       textWidgets.add(
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Container(
//                             alignment: Alignment.center,
//                             height: 50,
//                             color: Colors.amber,
//                             child: Text(
//                               myVar['disease'],
//                               style: TextStyle(
//                                   color: Colors.black, fontSize: 30.0),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   }

//                   return Flexible(
//                     child: ListView(
//                       // reverse: true,
//                       children: textWidgets,
//                     ),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }














// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:agri_well/components/utility_classes/format_time.dart';
// import 'package:agri_well/constants.dart';
// import 'package:agri_well/history_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DetailScreen extends StatefulWidget {
//   final double confidence;
//   final String imageUrl;
//   final String plantName;
//   final DateTime time;
//   final String disease;
//   String docId;
//   final bool isFromResultScreen;

//   bool loadShimmer = false;
//   User? user;
//   DetailScreen(
//       {super.key,
//       required this.disease,
//       required this.confidence,
//       required this.imageUrl,
//       required this.plantName,
//       required this.time,
//       required this.user,
//       required this.docId,
//       required this.isFromResultScreen});

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   Widget getAttentionCard() {
//     if (widget.disease == 'Healthy') {
//       return Text('');
//     }

//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Color(0xffFFE4B3),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         'Atterntion',
//         style: TextStyle(color: Colors.orange, fontSize: 12.sp),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: kWhiteColor,
//         appBar: AppBar(
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Icon(
//                 FontAwesomeIcons.user,
//                 color: kTextColor,
//                 size: 23.h,
//               ),
//             ),
//           ],
//           elevation: 0,
//           backgroundColor: kWhiteColor,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: kTextColor,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0, vertical: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                                 child: Container(
//                               height: 250.h,
//                               decoration: BoxDecoration(),
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(15.r),
//                                   child: CachedNetworkImage(
//                                     imageUrl: widget.imageUrl,
//                                     fit: BoxFit.fill,
//                                     placeholder: (context, url) =>
//                                         getAttentionCard(),
//                                   )),
//                             )),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.disease,
//                                   style: TextStyle(
//                                       fontSize: 24.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: kTextColor),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       // margin: EdgeInsets.only(left: 8.w),
//                                       height: 8.h,
//                                       width: 8.h,
//                                       decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius:
//                                               BorderRadius.circular(50)),
//                                     ),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     Text(
//                                       TimeFormatter.formatDate(widget.time),
//                                       style: TextStyle(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: kLightColor),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 getAttentionCard(),
//                                 SizedBox(
//                                   width: 5.w,
//                                 ),
//                                 Icon(Icons.more_vert),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 40.h),
//                         // Padding(
//                         //   padding: const EdgeInsets.only(right: 25),
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //     children: [
//                         //       MidTextWidget(
//                         //         head: 'Score',
//                         //         bottom: '100',
//                         //       ),
//                         //       MidTextWidget(
//                         //         head: 'Plant',
//                         //         bottom: 'Tomato',
//                         //       ),
//                         //       Column(
//                         //         crossAxisAlignment: CrossAxisAlignment.start,
//                         //         children: [
//                         //           Text(
//                         //             'Chat',
//                         //             style: TextStyle(
//                         //                 color: kLightColor1, fontSize: 15.sp),
//                         //           ),
//                         //           Icon(Icons.ios_share_rounded)
//                         //         ],
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 8.w, top: 15.h, bottom: 15.h, right: 4.w),
//                           decoration: BoxDecoration(
//                               color: Color(0xffE9F1FE),
//                               borderRadius: BorderRadius.circular(8.r)),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Icon(
//                                 Icons.info_outline,
//                                 color: Color(0xff414C81),
//                               ),
//                               SizedBox(
//                                 width: 5.w,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Please check the symptoms below with your plants condition before treating ',
//                                   style: TextStyle(
//                                       color: Color(0xff414C81),
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14.sp),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.bookMedical),
//                             SizedBox(width: 5.w),
//                             Text(
//                               'Symptoms',
//                               style: TextStyle(
//                                   color: kLightColor2,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 22.sp),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         SizedBox(
//                           height: 300.h,
//                           // color: Colors.white,

//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Early symptoms include yellowing of leaves,browning of leaf edges, and spots on the leaves.',
//                                     ),
//                                     SizedBox(
//                                       height: 6.h,
//                                     ),
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Stems and branches may also become discolored, with dark streaks or patches.',
//                                     ),
//                                     SizedBox(
//                                       height: 6.h,
//                                     ),
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Fruits can develop sunken, dark spots or patches.',
//                                     ),
//                                     SizedBox(
//                                       height: 6.h,
//                                     ),
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Brown lesions may form on the stems and petioles, eventually leading to wilting of the plant.',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.syringe),
//                             SizedBox(width: 5.w),
//                             Text(
//                               'Treatment',
//                               style: TextStyle(
//                                   color: kLightColor2,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 23.sp),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         CutomSymptomTextWidget(
//                             symptom:
//                                 'For treating cherry powdery mildew some effective organic fungicides  are sulfur, lime-sulfur, neem oil, and potassium bicarbonate. These are most effective when used prior to infection or when you first see signs of the disease.Baking soda has been proved by many gardeners to be effective in treating powdery mildew.'),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.fileMedical),
//                             SizedBox(width: 5.w),
//                             Text(
//                               'Recommendation',
//                               style: TextStyle(
//                                   color: kLightColor2,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 23.sp),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         CutomSymptomTextWidget(
//                             symptom:
//                                 'For treating cherry powdery mildew some effective organic fungicides  are sulfur, lime-sulfur, neem oil, and potassium bicarbonate. These are most effective when used prior to infection or when you first see signs of the disease.Baking soda has been proved by many gardeners to be effective in treating powdery mildew.'),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CutomSymptomTextWidget extends StatelessWidget {
//   String symptom;
//   CutomSymptomTextWidget({
//     super.key,
//     required this.symptom,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       symptom,
//       style: TextStyle(
//           color: kLightColor2, fontSize: 15.sp, fontWeight: FontWeight.w400),
//     );
//   }
// }

// class MidTextWidget extends StatelessWidget {
//   final String head;
//   final String bottom;

//   const MidTextWidget({super.key, required this.head, required this.bottom});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           head,
//           style: TextStyle(color: kLightColor1, fontSize: 15.sp),
//         ),
//         Text(
//           bottom,
//           style: TextStyle(
//               color: kLightColor2,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }



// // Container(
// //                               alignment: Alignment.center,
// //                               height: 23,
// //                               width: 23,
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(5.r),
// //                                 color: kGreenColor,
// //                               ),
// //                               child: Text(
// //                                 '1',
// //                                 style: TextStyle(
// //                                     color: kWhiteColor,
// //                                     fontWeight: FontWeight.bold),
// //                               ),
// //                             ),








// // // ignore_for_file: prefer_const_constructors, unused_label, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_field

// // import 'package:agri_well/constants.dart';
// // import 'package:agri_well/leaf_scan.dart';
// // import 'package:agri_well/main_page.dart';
// // import 'package:agri_well/result_page.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:shimmer/shimmer.dart';
// // import 'package:cached_network_image/cached_network_image.dart';

// // import 'chat_screen.dart';
// // import 'components/utility_classes/format_time.dart';
// // import 'details.dart';

// // class HistoryScreen extends StatefulWidget {
// //   const HistoryScreen({super.key});

// //   @override
// //   State<HistoryScreen> createState() => _HistoryScreenState();
// // }

// // class _HistoryScreenState extends State<HistoryScreen> {
// //   final _firestore = FirebaseFirestore.instance;
// //   final _auth = FirebaseAuth.instance;
// //   late Widget listView;
// //   late Stream _stream;
// //   bool showShimmer = true;

// //   User? currentUser;

// //   void getCurrentUser() {
// //     try {
// //       currentUser = _auth.currentUser;
// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   @override
// //   void initState() {
// //     getCurrentUser();

// //     _stream = FirebaseFirestore.instance
// //         .collection('user_data')
// //         .doc(currentUser!.uid)
// //         .collection('predictions')
// //         .orderBy('timestamp', descending: true)
// //         .snapshots();
// //     print(_stream);

// //     print('Custom Stream : $_stream ');

// //     print('init called');

// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         backgroundColor: Color(0xffffffff),
// //         body: Column(
// //           children: [
// //             DataStream(currentUser: currentUser, stream: _stream),
// //           ],
// //         ));
// //   }
// // }

// // class DataStream extends StatelessWidget {
// //   DataStream({
// //     super.key,
// //     required this.currentUser,
// //     required this.stream,
// //   });

// //   final User? currentUser;
// //   final Stream stream;

// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder(
// //       stream: stream,
// //       builder: (context, snapshot) {
// //         List<CustomHistoryCardView> databaseCard = [];

// //         if (snapshot.hasData) {
// //           final fetchedDocuments = snapshot.data!.docs;

// //           int i = 0;

// //           for (var pair in fetchedDocuments) {
// //             var data = pair.data();
// //             // print(i);
// //             DocumentSnapshot documentSnapshot = fetchedDocuments[i];
// //             String docId = documentSnapshot.id;

// //             print('$i $docId');

// //             final confidence = data['confidence'];
// //             final imageUrl = data['imageurl'];
// //             final plantName = data['plant_name'];
// //             Timestamp time = data['timestamp'];
// //             final disease = data['disease'];

// //             DateTime dateTime = time.toDate();

// //             double convertedConfidence = double.parse(confidence);

// //             databaseCard.add(CustomHistoryCardView(
// //               disease: disease,
// //               confidence: convertedConfidence,
// //               imageUrl: imageUrl,
// //               plantName: plantName,
// //               time: dateTime,
// //               user: currentUser,
// //               docId: docId,
// //             ));

// //             i++;
// //           }
// //           return Flexible(
// //             child: ListView(
// //               physics: BouncingScrollPhysics(),
// //               children: [
// //                 Text('Data'),
// //                 Text('Data'),
// //                 Text('Data'),
// //                 Text('Data'),
// //                 Text('Data'),
// //                 Text('Data'),
// //                 Text('Data'),
// //                 Text('Data'),
// //               ],
// //             ),
// //           );
// //         }
// //         return Center(
// //           child: Text('No data'),
// //         );
// //       },
// //     );
// //   }
// // }

// // class CustomHistoryCardView extends StatelessWidget {
// //   final double confidence;
// //   final String imageUrl;
// //   final String plantName;
// //   final DateTime time;
// //   final String disease;
// //   final String docId;

// //   bool loadShimmer = false;
// //   User? user;
// //   // ignore: non_constant_identifier_names

// //   Color whatColor() {
// //     if (confidence > 75) {
// //       return kGreenNormal;
// //     } else if (confidence > 50) {
// //       return kOrangeNormal;
// //     }
// //     return kRedNormal;
// //   }

// //   CustomHistoryCardView(
// //       {super.key,
// //       required this.disease,
// //       required this.confidence,
// //       required this.imageUrl,
// //       required this.plantName,
// //       required this.time,
// //       required this.user,
// //       required this.docId});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
// //         //   return DetailScreen();
// //         // }));
// //       },
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Container(
// //               margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
// //               height: 150.h,
// //               decoration: BoxDecoration(
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Color(0xFFEEEEEE),
// //                     blurRadius: 44,
// //                     blurStyle: BlurStyle.outer,
// //                   ),
// //                 ],
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(15.r),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Container(
// //                     margin: const EdgeInsets.all(12.0),
// //                     height: 140.h,
// //                     width: 140.h,
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(15.r),
// //                       child: CachedNetworkImage(
// //                         imageUrl: imageUrl,
// //                         fit: BoxFit.cover,
// //                         placeholder: (context, url) => getShimmerLoading(),
// //                       ),
// //                     ),
// //                   ),
// //                   Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           SizedBox(
// //                             height: 30.h,
// //                             child: Text(
// //                               disease,
// //                               style: TextStyle(
// //                                   color: kTextColor,
// //                                   fontSize: 18.sp,
// //                                   fontWeight: FontWeight.w500),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(
// //                         height: 10.h,
// //                       ),
// //                       Row(
// //                         children: [
// //                           SvgPicture.asset('assets/plant_icon.svg'),
// //                           SizedBox(
// //                             width: 5.w,
// //                           ),
// //                           Expanded(
// //                             child: Text(
// //                               plantName,
// //                               style: TextStyle(
// //                                   color: Color(0xFF999999),
// //                                   fontSize: 15.sp,
// //                                   fontWeight: FontWeight.w300),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(
// //                         height: 10.h,
// //                       ),
// //                       Row(
// //                         children: [
// //                           SvgPicture.asset('assets/calender.svg'),
// //                           SizedBox(
// //                             width: 5.w,
// //                           ),
// //                           Text(
// //                             TimeFormatter.formatDate(time),
// //                             style: TextStyle(
// //                                 color: Color(0xFF999999),
// //                                 fontSize: 15.sp,
// //                                 fontWeight: FontWeight.w300),
// //                           ),
// //                           SizedBox(
// //                             width: 10.w,
// //                           ),
// //                           Flexible(
// //                             child: Container(
// //                               padding: EdgeInsets.symmetric(
// //                                   vertical: 2, horizontal: 15),
// //                               decoration: BoxDecoration(
// //                                   color: whatColor(),
// //                                   borderRadius: BorderRadius.circular(100.r)),
// //                               child: Text(
// //                                 // textAlign: TextAlign.center,
// //                                 '$confidence%',
// //                                 style: TextStyle(color: Colors.white),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // Shimmer getShimmerLoading() {
// //   return Shimmer.fromColors(
// //     baseColor: Colors.grey[300]!,
// //     highlightColor: Colors.grey[100]!,
// //     child: Container(
// //       height: 120.h,
// //       width: 120.w,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(10),
// //         color: Colors.white,
// //       ),
// //     ),
// //   );
// // }



// oooooooooooooooooooooooooooo



// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:agri_well/utility_classes/format_time.dart';
// import 'package:agri_well/constants.dart';
// import 'package:agri_well/utility_classes/get_treatment_data.dart';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DetailScreen extends StatefulWidget {
//   final double confidence;
//   final dynamic imageUrl;
//   final String plantName;
//   final DateTime time;
//   final String disease;
//   final String docId;
//   final bool isFromResultScreen;

//   bool loadShimmer = false;
//   User? user;
//   DetailScreen(
//       {super.key,
//       required this.disease,
//       required this.confidence,
//       required this.imageUrl,
//       required this.plantName,
//       required this.time,
//       required this.user,
//       required this.docId,
//       required this.isFromResultScreen});

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   late Stream _stream;
//   late List<Text> listOfFetchedData;
//   Widget getAttentionCard() {
//     if (widget.disease == 'Healthy') {
//       return Text('');
//     }

//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Color(0xffFFE4B3),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         'Atterntion',
//         style: TextStyle(color: Colors.orange, fontSize: 12.sp),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     print('Details Screen init called');
//     _stream = FirebaseFirestore.instance
//         .collection('plant_treatment')
//         .doc(widget.disease)
//         .snapshots();

//     super.initState();
//   }

  

//   @override
//   Widget build(BuildContext context) {
    
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: kWhiteColor,
//         appBar: AppBar(
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Icon(
//                 FontAwesomeIcons.user,
//                 color: kTextColor,
//                 size: 23.h,
//               ),
//             ),
//           ],
//           elevation: 0,
//           backgroundColor: kWhiteColor,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: kTextColor,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0, vertical: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                                 child: Container(
//                               height: 250.h,
//                               decoration: BoxDecoration(),
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(15.r),
//                                   child: widget.isFromResultScreen
//                                       ? Image.file(
//                                           widget.imageUrl,
//                                           fit: BoxFit.fill,
//                                         )
//                                       : CachedNetworkImage(
//                                           imageUrl: widget.imageUrl,
//                                           fit: BoxFit.fill,
//                                           placeholder: (context, url) =>
//                                               getAttentionCard(),
//                                         )),
//                             )),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.disease,
//                                   style: TextStyle(
//                                       fontSize: 24.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: kTextColor),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       // margin: EdgeInsets.only(left: 8.w),
//                                       height: 8.h,
//                                       width: 8.h,
//                                       decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius:
//                                               BorderRadius.circular(50)),
//                                     ),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     Text(
//                                       TimeFormatter.formatDate(widget.time),
//                                       style: TextStyle(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: kLightColor),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 getAttentionCard(),
//                                 SizedBox(
//                                   width: 5.w,
//                                 ),
//                                 Icon(Icons.more_vert),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 40.h),
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 8.w, top: 15.h, bottom: 15.h, right: 4.w),
//                           decoration: BoxDecoration(
//                               color: Color(0xffE9F1FE),
//                               borderRadius: BorderRadius.circular(8.r)),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Icon(
//                                 Icons.info_outline,
//                                 color: Color(0xff414C81),
//                               ),
//                               SizedBox(
//                                 width: 5.w,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Please check the symptoms below with your plants condition before treating ',
//                                   style: TextStyle(
//                                       color: Color(0xff414C81),
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14.sp),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.bookMedical),
//                             SizedBox(width: 5.w),
//                             Text(
//                               'Symptoms',
//                               style: TextStyle(
//                                   color: kLightColor2,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 22.sp),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         SizedBox(
//                           height: 300.h,
//                           // color: Colors.white,

//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Early symptoms include yellowing of leaves,browning of leaf edges, and spots on the leaves.',
//                                     ),
//                                     SizedBox(
//                                       height: 6.h,
//                                     ),
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Stems and branches may also become discolored, with dark streaks or patches.',
//                                     ),
//                                     SizedBox(
//                                       height: 6.h,
//                                     ),
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Fruits can develop sunken, dark spots or patches.',
//                                     ),
//                                     SizedBox(
//                                       height: 6.h,
//                                     ),
//                                     CutomSymptomTextWidget(
//                                       symptom:
//                                           '● Brown lesions may form on the stems and petioles, eventually leading to wilting of the plant.',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.syringe),
//                             SizedBox(width: 5.w),
//                             Text(
//                               'Treatment',
//                               style: TextStyle(
//                                   color: kLightColor2,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 23.sp),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         // CutomSymptomTextWidget(
//                         //     symptom:
//                         //         'For treating cherry powdery mildew some effective organic fungicides  are sulfur, lime-sulfur, neem oil, and potassium bicarbonate. These are most effective when used prior to infection or when you first see signs of the disease.Baking soda has been proved by many gardeners to be effective in treating powdery mildew.'),
//                         GetTreatmentStream(
//                           stream: _stream,
//                           field: 'treatment',
//                         ),

//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.fileMedical),
//                             SizedBox(width: 5.w),
//                             Text(
//                               'Recommendation',
//                               style: TextStyle(
//                                   color: kLightColor2,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 23.sp),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         CutomSymptomTextWidget(
//                             symptom:
//                                 'For treating cherry powdery mildew some effective organic fungicides  are sulfur, lime-sulfur, neem oil, and potassium bicarbonate. These are most effective when used prior to infection or when you first see signs of the disease.Baking soda has been proved by many gardeners to be effective in treating powdery mildew.'),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CutomSymptomTextWidget extends StatelessWidget {
//   final String symptom;
//   const CutomSymptomTextWidget({
//     super.key,
//     required this.symptom,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       symptom,
//       style: TextStyle(
//           color: kLightColor2, fontSize: 15.sp, fontWeight: FontWeight.w400),
//     );
//   }
// }

// class MidTextWidget extends StatelessWidget {
//   final String head;
//   final String bottom;

//   const MidTextWidget({super.key, required this.head, required this.bottom});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           head,
//           style: TextStyle(color: kLightColor1, fontSize: 15.sp),
//         ),
//         Text(
//           bottom,
//           style: TextStyle(
//               color: kLightColor2,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }

// class GetTreatmentStream extends StatelessWidget {
//   final Stream stream;
//   final String field;
//   const GetTreatmentStream(
//       {super.key, required this.stream, required this.field});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: stream,
//         builder: (context, snapshot) {
//           List<Text> textList = [];
//           if (snapshot.hasData) {
//             final fetchedDocuments = snapshot.data;
//             String treatment;

//             try {
//               treatment = fetchedDocuments.data()[field];
//             } catch (e) {
//               treatment = 'No Data';
//             }
//             return Text(
//               treatment,
//               style: TextStyle(
//                   color: kLightColor2,
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w400),
//             );
//           }
//           return Text('Hello');
//         });
//   }
// }
