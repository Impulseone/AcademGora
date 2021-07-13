import 'package:academ_gora/model/instructor.dart';
import 'package:academ_gora/screens/extension.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class InstructorProfileScreen extends StatelessWidget {
  final Instructor instructor;

  const InstructorProfileScreen(this.instructor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: screenHeight,
      width: screenWidth,
      decoration: screenDecoration("assets/instructor_profile/bg.png"),
      child: Column(
        children: [
          _instructorPhoto(),
          _instructorNameWidget(),
          _instructorInfoWidget(),
          _instructorPhoneWidget(),
          _socialNetworksList(),
          _backButtons(context)
        ],
      ),
    ));
  }

  Widget _instructorPhoto() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.07),
      width: screenWidth * 0.55,
      height: screenHeight * 0.2,
      child: Image.asset("assets/instructor_profile/1.png"),
    );
  }

  Widget _instructorNameWidget() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          instructor.name,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }

  Widget _instructorInfoWidget() {
    return Container(
        height: screenHeight * 0.25,
        width: screenWidth * 0.8,
        margin: EdgeInsets.only(top: 10),
        child: Text(
          instructor.info,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Widget _instructorPhoneWidget() {
    return GestureDetector(
        onTap: () {
          callNumber("${instructor.phone}");
        },
        child: GestureDetector(
            onTap: () {
              callNumber(instructor.phone);
            },
            child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: screenWidth * 0.1),
                child: Text(
                  "Телефон: ${instructor.phone}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))));
  }

  Widget _socialNetworksList() {
    return Container(
      height: screenHeight * 0.25,
      child: ListView.builder(
          itemCount: instructor.socialNetworks.length,
          itemBuilder: (context, index) {
            return "${instructor.socialNetworks.values.toList()[index]}"
                    .isNotEmpty
                ? _socialNetworkWidget(
                    _getSocialNetworkImagePath(
                        "${instructor.socialNetworks.keys.toList()[index]}"),
                    "${instructor.socialNetworks.values.toList()[index]}")
                : Container();
          }),
    );
  }

  Widget _socialNetworkWidget(String path, String url) {
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
          GestureDetector(
              onTap: () {
                launchURL(url);
              },
              child: Container(
                width: screenWidth * 0.7,
                child: Text(
                  url == null ? "" : url,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              )),
        ],
      ),
    );
  }

  String _getSocialNetworkImagePath(String socialNetworkName) {
    switch (socialNetworkName) {
      case "instagram":
        return "assets/instructor_profile/social_network_icons/2insta.png";
        break;
      case "vk":
        return "assets/instructor_profile/social_network_icons/3vk.png";
        break;
      case "facebook":
        return "assets/instructor_profile/social_network_icons/4fb.png";
        break;
      case "ok":
        return "assets/instructor_profile/social_network_icons/5ok.png";
        break;
      case "twitter":
        return "assets/instructor_profile/social_network_icons/6twitter.png";
        break;
      case "tiktok":
        return "assets/instructor_profile/social_network_icons/7tiktok.png";
        break;
      case "youtube":
        return "assets/instructor_profile/social_network_icons/8youtube.png";
        break;
      case "telegram":
        return "assets/instructor_profile/social_network_icons/9telegram.png";
        break;
      default:
        return "";
        break;
    }
  }

  Widget _backButtons(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_backButton(context), _backToMainScreenButton(context)],
        ));
  }

  Widget _backButton(BuildContext context) {
    return ExpandTapWidget(
        tapPadding: EdgeInsets.all(50),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 20,
          height: 20,
          child: Image.asset("assets/instructor_profile/4.png"),
        ));
  }

  Widget _backToMainScreenButton(BuildContext context) {
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.05,
      margin: EdgeInsets.only(left: 20),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => MainScreen()),
                      (route) => false)
                },
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НА ГЛАВНУЮ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
