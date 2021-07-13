import 'package:academ_gora/controller/firebase_requests_controller.dart';
import 'package:academ_gora/model/Instructors_keeper.dart';
import 'package:academ_gora/model/instructor.dart';
import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/screens/account/instructor_profile/instructor_workouts_screen.dart';
import 'package:academ_gora/screens/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({Key key}) : super(key: key);

  @override
  _InstructorProfileScreenState createState() =>
      _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  Instructor _currentInstructor = Instructor();
  FirebaseRequestsController _firebaseController = FirebaseRequestsController();
  InstructorsKeeper _instructorsKeeper = InstructorsKeeper();

  @override
  void initState() {
    super.initState();
    _instructorsKeeper.addListener(this);
  }

  @override
  Widget build(BuildContext context) {
    _getInstructorInfo();
    return Scaffold(
        body: Container(
      width: screenWidth,
      decoration: screenDecoration("assets/instructor_profile/bg.png"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _instructorPhoto(),
          _redactPhotoButton(),
          _instructorName(),
          _instructorInfo(),
          _redactInstructorInfoButton(),
          _socialNetworksList(),
          _backButton()
        ],
      ),
    ));
  }

  Widget _instructorPhoto() {
    return Container(
        height: screenHeight * 0.1,
        width: screenWidth * 0.2,
        child: Image.asset("assets/instructors_list/e_3.png"));
  }

  Widget _redactPhotoButton() {
    return Container(
      width: screenWidth * 0.6,
      height: screenHeight * 0.05,
      margin: EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: () {},
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "РЕДАКТИРОВАТЬ ФОТО",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _instructorName() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        _currentInstructor.name == null ? "" : _currentInstructor.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _instructorInfo() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: screenHeight * 0.2,
        width: screenWidth * 0.8,
        child: SingleChildScrollView(
            child: Flex(
          direction: Axis.vertical,
          children: [
            Text(
              _currentInstructor.info == null ? "" : _currentInstructor.info,
              style: TextStyle(fontSize: 14),
            )
          ],
        )));
  }

  Widget _redactInstructorInfoButton() {
    return Container(
        child: GestureDetector(
      onTap: () => _showRedactInfoDialog(_currentInstructor.info, false),
      child: Text(
        "Редактировать информацию о себе",
        style: TextStyle(color: Colors.blue),
      ),
    ));
  }

  void _showRedactInfoDialog(String text, bool isSocialNetwork,
      {String socialNetworkName}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: _redactInfoDialogContent(text, isSocialNetwork,
              socialNetworkName: socialNetworkName),
        );
      },
    );
  }

  Widget _redactInfoDialogContent(String text, bool isSocialNetwork,
      {String socialNetworkName}) {
    TextEditingController myController = TextEditingController(text: text);
    return Container(
      height: screenHeight * 0.19,
      child: Column(
        children: [
          TextField(
              controller: myController,
              keyboardType: TextInputType.visiblePassword),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: OutlinedButton(
                      child: Text('ОК'),
                      onPressed: () {
                        _updateInstructorInfo(
                            myController.value.text, isSocialNetwork,
                            socialNetworkName: socialNetworkName);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  OutlinedButton(
                    child: Text('ОТМЕНА'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _updateInstructorInfo(String updatedText, bool isSocialNetwork,
      {String socialNetworkName}) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    Map<String, dynamic> info = {};
    String path = "";
    if (isSocialNetwork) {
      path = "${UserRole.instructor}/$userId/Соцсети";
      info = {socialNetworkName: updatedText};
    } else {
      path = "${UserRole.instructor}/$userId";
      info = {"Информация": updatedText};
    }
    await _firebaseController.update(path, info);
  }

  Widget _socialNetworksList() {
    var socialNetworksMap = {};
    if (_currentInstructor.socialNetworks != null &&
        _currentInstructor.socialNetworks.isNotEmpty) {
      socialNetworksMap = _currentInstructor.socialNetworks;
    }
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/1phone.png",
              text: FirebaseAuth.instance.currentUser.phoneNumber),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/2insta.png",
              text: socialNetworksMap["instagram"],
              socialNetworkName: "instagram"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/3vk.png",
              text: socialNetworksMap["vk"],
              socialNetworkName: "vk"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/4fb.png",
              text: socialNetworksMap["facebook"],
              socialNetworkName: "facebook"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/5ok.png",
              text: socialNetworksMap["ok"],
              socialNetworkName: "ok"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/6twitter.png",
              text: socialNetworksMap["twitter"],
              socialNetworkName: "twitter"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/7tiktok.png",
              text: socialNetworksMap["tiktok"],
              socialNetworkName: "tiktok"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/8youtube.png",
              text: socialNetworksMap["youtube"],
              socialNetworkName: "youtube"),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/9telegram.png",
              text: socialNetworksMap["telegram"],
              socialNetworkName: "telegram"),
        ],
      ),
    );
  }

  Widget _socialNetworkWidget(String path,
      {String text, String socialNetworkName}) {
    return Container(
      margin: EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 22,
            width: 22,
            child: Image.asset(path),
          ),
          Container(
            width: screenWidth * 0.6,
            child: Text(
              text == null ? "" : text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          text != FirebaseAuth.instance.currentUser.phoneNumber
              ? GestureDetector(
                  onTap: () => _showRedactInfoDialog(text, true,
                      socialNetworkName: socialNetworkName),
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 20,
                    width: 20,
                    child: Image.asset(
                        "assets/instructor_profile/social_network_icons/0edit.png"),
                  ))
              : Container(
                  height: 20, width: 20, margin: EdgeInsets.only(right: 15)),
        ],
      ),
    );
  }

  Widget _backButton() {
    return Container(
      width: screenWidth * 0.6,
      height: screenHeight * 0.05,
      margin: EdgeInsets.only(top: 25),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openInstructorWorkoutsScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НАЗАД",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  void _getInstructorInfo() async {
    setState(() {
      _currentInstructor = _instructorsKeeper.findInstructorByPhoneNumber(
          FirebaseAuth.instance.currentUser.phoneNumber);
    });
  }

  void _openInstructorWorkoutsScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => InstructorWorkoutsScreen()),
        (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    _instructorsKeeper.removeListener(this);
  }
}
