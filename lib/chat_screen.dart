// ignore_for_file: prefer_const_constructors

import 'package:agri_well/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'account_info_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User? user;
  TextEditingController messageTextController = TextEditingController();
  late final FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _firestore = FirebaseFirestore.instance;
  }

  void getCurrentUser() {
    if (_auth.currentUser != null) {
      try {
        user = _auth.currentUser;
      } catch (e) {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        elevation: 0.2,
        title: Text(
          'Community',
          style: TextStyle(
            color: kTextColor,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20.w),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return AccountInfoScreen();
              }));
            },
            icon: Icon(
              FontAwesomeIcons.user,
              size: 23.h,
              color: kTextColor,
            ),
          )
        ],
      ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F8F8),

      body: Column(
        children: [
          MessageStreamBuilder(user: user!, firestore: _firestore),
          Container(
              alignment: Alignment.center,
              height: 100.h,
              decoration: BoxDecoration(color: kWhiteColor),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                alignment: Alignment.center,
                height: 65.h,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(200)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: messageTextController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.message,
                              color: kDarkGreen,
                            ),
                            hintText: 'Type here...',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (messageTextController.text.isNotEmpty) {
                          await _firestore.collection('messages').add({
                            'text': messageTextController.text.trim(),
                            'time': DateTime.now(),
                            'id': user!.email,
                            'name': user!.displayName
                          });
                          messageTextController.clear();
                        }
                      },
                      icon: Icon(Icons.send),
                      color: kDarkGreen,
                    )
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}

class MessageStreamBuilder extends StatelessWidget {
  final User user;
  final FirebaseFirestore firestore;

  const MessageStreamBuilder(
      {super.key, required this.user, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection(
              'messages',
            )
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<Widget> listOfMessage = [];

          if (snapshot.hasData) {
            final fetchedDocuments = snapshot.data!.docs;
            var data = fetchedDocuments;
            int i = 0;
            for (var message in data) {
              DocumentSnapshot documentSnapshot = fetchedDocuments[i];
              String messageId = documentSnapshot.id;

              Timestamp time = message['time'];

              DateTime dateTime = time.toDate();

              listOfMessage.add(MessageBubble(
                firestore: firestore,
                isThisUser: user.email == message['id'] ? true : false,
                text: message['text'],
                dateTime: dateTime,
                messgaeId: messageId,
                userName: message['name'],
                official: officialMails.contains(
                  message['id'],
                ),
              ));

              i++;
            }
          }

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: ListView(
                addAutomaticKeepAlives: true,
                physics: BouncingScrollPhysics(),
                reverse: true,
                children: listOfMessage,
              ),
            ),
          );
        });
  }
}

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isThisUser;
  final DateTime dateTime;
  final String messgaeId;
  final bool official;
  final String? userName;
  final FirebaseFirestore firestore;

  const MessageBubble(
      {super.key,
      required this.text,
      required this.userName,
      required this.official,
      required this.isThisUser,
      required this.dateTime,
      required this.messgaeId,
      required this.firestore});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isThisUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: widget.isThisUser
              ? () async {
                  setState(() {
                    visible = true;
                  });
                }
              : null,
          child: Row(
            mainAxisAlignment: widget.isThisUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              widget.isThisUser
                  ? Visibility(
                      visible: visible,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                visible = false;
                              });

                              if (widget.isThisUser) {
                                await widget.firestore
                                    .collection('messages')
                                    .doc(widget.messgaeId)
                                    .delete();
                              }
                            },
                            icon: Icon(FontAwesomeIcons.trashCan),
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                        ],
                      ),
                    )
                  : Text(''),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      visible = false;
                    });
                  },
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 25.h),
                    padding: EdgeInsets.only(
                        left: 10.w, top: 10.h, bottom: 10.h, right: 30.w),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),

                    decoration: BoxDecoration(
                        color: widget.isThisUser ? kDarkGreen : kWhiteColor,
                        borderRadius: BorderRadius.only(
                            topRight: !widget.isThisUser
                                ? Radius.circular(15.r)
                                : Radius.zero,
                            topLeft: widget.isThisUser
                                ? Radius.circular(15.r)
                                : Radius.zero,
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.userName!,
                              style: TextStyle(
                                  color: widget.isThisUser
                                      ? Colors.yellow
                                      : kDarkGreen,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            widget.official
                                ? Icon(Icons.verified,
                                    size: 15.h,
                                    color: widget.isThisUser
                                        ? kWhiteColor
                                        : kDarkGreen)
                                : Text(''),
                          ],
                        ),
                        Text(
                          widget.text,
                          style: TextStyle(
                              color:
                                  widget.isThisUser ? kWhiteColor : kTextColor,
                              fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          '${DateFormat('d MMMM y').format(widget.dateTime)} ${DateFormat("hh:mm a").format(widget.dateTime)}',
          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
