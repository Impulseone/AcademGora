import 'package:academ_gora/screens/all_instructors/all_instructors_screen.dart';
import 'package:academ_gora/screens/info_screens/about_us_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../main_screen.dart';

final List<String> imgList = [
  "assets/info_screens/about_us/0.jpg",
  "assets/info_screens/about_us/1.jpg",
  "assets/info_screens/about_us/2.jpg",
  "assets/info_screens/about_us/3.jpg",
  "assets/info_screens/about_us/4.jpg",
];

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/info_screens/about_us/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _title(),
          _slider(),
          _description(),
          _button(context, "НАШИ ИНСТРУКТОРЫ"),
          _button(context, "НА ГЛАВНУЮ")
        ],
      ),
    ));
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(top: screenHeight * 0.07),
        child: Text(
          "СК \"АКАДЕМИЧЕСКИЙ\"",
          style: TextStyle(
              fontSize: screenHeight * 0.024, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }

  Widget _slider() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            CarouselSlider(
              items: _getImagesForSlider(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }

  List<Widget> _getImagesForSlider() {
    return imgList
        .map(
          (item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Image.asset(item),
            ),
          ),
        )
        .toList();
  }

  Widget _description() {
    return Container(
        height: screenHeight * 0.32,
        width: screenWidth * 0.8,
        child: SingleChildScrollView(
            child: Flex(
          direction: Axis.vertical,
          children: [
            Text(
              AboutUs.aboutUs(),
              style: TextStyle(fontSize: 12),
            )
          ],
        )));
  }

  Widget _button(BuildContext context, String text) {
    return Container(
      width: screenWidth * 0.63,
      height: screenHeight * 0.08,
      margin: EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: () => text == "НАШИ ИНСТРУКТОРЫ"
                ? _openInstructorsScreen()
                : _openMainScreen(),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight*0.027,
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }

  void _openMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
  }

  void _openInstructorsScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => AllInstructorsScreen()));
  }
}
