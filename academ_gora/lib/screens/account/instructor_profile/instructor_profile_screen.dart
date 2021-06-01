import 'package:academ_gora/controller/firebase_controller.dart';
import 'package:academ_gora/model/instructor.dart';
import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/screens/account/instructor_profile/instructor_workouts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({Key key}) : super(key: key);

  @override
  _InstructorProfileScreenState createState() =>
      _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  double _screenHeight;
  double _screenWidth;
  Instructor _currentInstructor = Instructor();

  @override
  void initState() {
    super.initState();
    _getInstructorInfo();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: _screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/instructor_profile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
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
        height: _screenHeight * 0.1,
        width: _screenWidth * 0.2,
        child: Image.asset("assets/instructors_list/e_3.png"));
  }

  Widget _redactPhotoButton() {
    return Container(
      width: _screenWidth * 0.6,
      height: _screenHeight * 0.05,
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
        height: _screenHeight * 0.2,
        width: _screenWidth * 0.8,
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
      child: Text(
        "Редактировать информацию о себе",
        style: TextStyle(color: Colors.blue),
      ),
    ));
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
              text: socialNetworksMap["instagram"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/3vk.png",
              text: socialNetworksMap["vk"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/4fb.png",
              text: socialNetworksMap["facebook"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/5ok.png",
              text: socialNetworksMap["ok"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/6twitter.png",
              text: socialNetworksMap["twitter"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/7tiktok.png",
              text: socialNetworksMap["tiktok"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/8youtube.png",
              text: socialNetworksMap["youtube"]),
          _socialNetworkWidget(
              "assets/instructor_profile/social_network_icons/9telegram.png",
              text: socialNetworksMap["telegram"]),
        ],
      ),
    );
  }

  Widget _socialNetworkWidget(String path, {String text}) {
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
            width: _screenWidth * 0.5,
            child: Text(
              text == null ? "" : text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 20,
            width: 20,
            child: Image.asset(
                "assets/instructor_profile/social_network_icons/0edit.png"),
          ),
        ],
      ),
    );
  }

  Widget _backButton() {
    return Container(
      width: _screenWidth * 0.6,
      height: _screenHeight * 0.05,
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
    FirebaseController firebaseController = FirebaseController();
    await UserRole.getUserRole().then((userRole) async {
      Instructor instructor = Instructor();
      if (userRole == UserRole.instructor) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        Map<dynamic, dynamic> instructorInfo =
            await firebaseController.get("$userRole/$userId");
        instructor = Instructor.fromJson(instructorInfo);
      }
      setState(() {
        _currentInstructor = instructor;
      });
    });
  }

  void _openInstructorWorkoutsScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => InstructorWorkoutsScreen()),
        (route) => false);
  }
}
