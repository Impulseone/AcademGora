import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

final List<String> imgList = [
  "assets/info_screens/one.jpg",
  "assets/info_screens/two.jpg",
  "assets/info_screens/three.jpg",
  "assets/info_screens/four.jpg",
];

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double screenWidth;
  double screenHeight;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/info_screens/bg.png"),
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
        margin: EdgeInsets.only(top: screenHeight * 0.14),
        child: Text(
          "СК \"АКАДЕМИЧЕСКИЙ\"",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }

  Widget _slider() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: CarouselSlider(
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
    );
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
        height: screenHeight * 0.25,
        width: screenWidth * 0.8,
        child: SingleChildScrollView(
            child: Text(
          "На базе работает два подъемника – кресельный и веревочный.\nТри трассы для катания.",
          style: TextStyle(fontSize: 12),
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
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
