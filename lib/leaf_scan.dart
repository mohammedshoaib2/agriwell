// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, sized_box_for_whitespace
import 'dart:io';
import 'package:agri_well/components/loading_animation.dart';
import 'package:agri_well/constants.dart';
import 'package:agri_well/result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'components/custom_button.dart';
import 'components/custom_text.dart';

class LeafScan extends StatefulWidget {
  static const String id = 'LeafScan';
  final String modelName;

  //parameters passed from home screen
  const LeafScan({Key? key, required this.modelName}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LeafScan> createState() => _LeafScanState(modelName);
}

User? currentUser;

class _LeafScanState extends State<LeafScan> {
  String modelName;
  _LeafScanState(this.modelName);
  final _firebaseCloud = FirebaseStorage.instance;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void getCurrentUser() {
    currentUser = _auth.currentUser;
  }

  Future<void> addData({
    required String? uid,
    required String? disease,
    required String? plantName,
    required String? confidence,
    required String? imageUrl,
    required DateTime? dateTime,
  }) async {
    try {
      if (uid != null && disease != null) {
        await _firestore
            .collection('user_data')
            .doc(uid)
            .collection('predictions')
            .add({
          'disease': disease_name,
          'confidence': confidence,
          'plant_name': plantName,
          'imageurl': imageUrl,
          'timestamp': dateTime,
        });
      }
    } catch (error) {
      // print(error);
    }
  }

  Future addImageToDataBase(File? file) async {
    if (file == null) return;
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = _firebaseCloud.ref();
    Reference referenceDirImages = reference.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      leafImageUrl = await referenceImageToUpload.getDownloadURL();
      // ignore: empty_catches
    } catch (e) {}
  }

  File? pickedImage;
  bool isButtonPressedCamera = false;
  bool isButtonPressedGallery = false;

  List? results;
  bool showLoadingAnimation = false;
  String confidence = "";
  String name = "";
  String crop_name = "";
  String disease_name = "";
  String disease_url = "";
  String leafImageUrl = '';
  bool result_visibility = false;
  String appBarText = 'Scan';
  bool showLeadingIcon = false;

  String ModelPathSelector() {
    if (modelName.toLowerCase() == "apple") {
      return 'models/Apple';
    } else if (modelName.toLowerCase() == "bellpepper") {
      return 'models/BellPepper';
    } else if (modelName.toLowerCase() == "cherry") {
      return 'models/Cherry';
    } else if (modelName.toLowerCase() == "corn") {
      return 'models/Corn';
    } else if (modelName.toLowerCase() == "grape") {
      return 'models/Grape';
    } else if (modelName.toLowerCase() == "peach") {
      return 'models/Peach';
    } else if (modelName.toLowerCase() == "potato") {
      return 'models/Potato';
    } else if (modelName.toLowerCase() == "rice") {
      return 'models/Rice';
    } else if (modelName.toLowerCase() == "tomato") {
      return 'models/Tomato';
    } else {
      return "";
    }
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        final imageTemporary = File(image.path);

        setState(() {
          pickedImage = imageTemporary;
          showLoadingAnimation = true;

          applyModelOnImage(pickedImage!);

          result_visibility = true;
          isButtonPressedCamera = false;
          isButtonPressedGallery = false;
        });
      }
    } on PlatformException {
      // print("Failed to pick image: $e");
    }
  }

  void buttonPressedCamera() {
    setState(() {
      isButtonPressedCamera = !isButtonPressedCamera;
      getImage(ImageSource.camera);
    });
  }

  void buttonPressedGallery() {
    setState(() {
      isButtonPressedGallery = !isButtonPressedGallery;
      getImage(ImageSource.gallery);
    });
  }

  @override
  void initState() {
    super.initState();
    // print(modelName);
    loadModel().then((val) {
      setState(() {});
    });

    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();

    closeModel();
  }

  loadModel() async {
    String modelPath = ModelPathSelector();
    // print(modelPath);
    // ignore: unused_local_variable
    var resultant = await Tflite.loadModel(
        model: modelPath + "/model_unquant.tflite",
        labels: modelPath + "/labels.txt");

    // print("Result after loading model: $resultant");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    await addImageToDataBase(file);

    await Future.delayed(Duration(seconds: 7), () {
      setState(() {
        showLoadingAnimation = false;
        appBarText = 'Result';
        showLeadingIcon = true;
      });
    });

    setState(() {
      results = res!;

      String str = results![0]["label"];
      name = str.substring(2);
      confidence = results != null
          ? (results![0]["confidence"] * 100.0).toString().substring(0, 5)
          : "";

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ResultPage(
          pickedImage: leafImageUrl,
          confidence: confidence,
          disease: disease_name,
          plantName: crop_name,
        );
      }));

      // print(name);
      // print(confidence);
      split_model_result();
    });
    await addData(
      uid: currentUser!.uid,
      disease: disease_name,
      confidence: confidence,
      plantName: modelName,
      imageUrl: leafImageUrl,
      dateTime: DateTime.now(),
    );
  }

  void split_model_result() {
    List temp = name.split(' ');
    crop_name = temp[0];
    temp.removeAt(0);
    disease_name = temp.join(' ');
    // print(crop_name);
    // print(disease_name);
  }

  void closeModel() async {
    await Tflite.close();
  }

  @override
  void didChangeDependencies() {
    FocusScope.of(context).unfocus();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffe9edf1),
      systemNavigationBarColor: secondaryColor,
    ));

    return Scaffold(
      appBar: !showLoadingAnimation
          ? AppBar(
              title: Text(
                'Scan',
                style: TextStyle(color: kTextColor),
              ),
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
            )
          : null,
      backgroundColor: backgroundColor,
      body: showLoadingAnimation
          ? LoadingAnimation()
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 300.h,
                              width: 3000.w,
                              child: Image.asset(
                                'assets/place_holder.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Column(
                        children: [
                          CustomText(
                            headText: 'Find Disease',
                            BottomText: 'Scan Now',
                          ),
                          SizedBox(
                            height: 26.h,
                          ),
                          Center(
                            child: Text(
                              'Images other than the specific plant\'s\nleaves may lead to inaccurate results',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: kTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                label: 'Scan',
                                clr: kGreenColor,
                                onTap: () {
                                  setState(() {
                                    isButtonPressedCamera = true;
                                    buttonPressedCamera();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomButton(
                                label: 'Upload',
                                clr: kDarkGreen,
                                onTap: () {
                                  setState(() {
                                    isButtonPressedGallery = true;
                                    buttonPressedGallery();
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
