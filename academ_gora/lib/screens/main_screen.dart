import 'package:academ_gora/screens/account/user_account_screen.dart';
import 'package:academ_gora/screens/info_screens/call_us_screen.dart';
import 'package:academ_gora/screens/info_screens/chill_zone_screen.dart';
import 'package:academ_gora/screens/info_screens/about_us_screen.dart';
import 'package:academ_gora/screens/info_screens/price_screen.dart';
import 'package:academ_gora/screens/info_screens/regime_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'registration_to_workout/registration_first_screen.dart';

final List<String> imgList = [
  "assets/main/10_pic1.png",
  "assets/main/10_pic2.png",
  "assets/main/10_pic3.png",
  "assets/main/10_pic4.png"
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Stack(
              children: <Widget>[
                Image.asset(item),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    alignment: Alignment.topRight,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'Время \nкатать',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ))
    .toList();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> buttons = [];
  int _current = 0;
  double _screenHeight;
  double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/main/background.svg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Column(
            children: [
              _titleAndAccButton(),
              _socialNetworks(),
              _slider(),
              _buttons(),
              _registrationToInstructorButton(),
              _infoButtons()
            ],
          ))),
    );
  }

  Widget _titleAndAccButton() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(left: 74),
                child: Text(
                  "СК \"АКАДЕМИЧЕСКИЙ\"",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )),
            GestureDetector(
                onTap: _openAccountScreen,
                child: Container(
                    width: 26,
                    height: 26,
                    margin: EdgeInsets.only(left: 40),
                    child: Image.asset("assets/main/lk.svg"))),
          ],
        ));
  }

  void _openAccountScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => UserAccountScreen()));
  }

  Widget _socialNetworks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: _screenWidth * 0.1,
            height: _screenWidth * 0.1,
            child: Image.asset("assets/main/2_phone.png")),
        Container(
            width: _screenWidth * 0.1,
            height: _screenWidth * 0.1,
            margin: EdgeInsets.only(left: 18),
            child: Image.asset("assets/main/3_insta.png")),
        Container(
            width: _screenWidth * 0.1,
            height: _screenWidth * 0.1,
            margin: EdgeInsets.only(left: 18),
            child: Image.asset("assets/main/4_vk.png")),
      ],
    );
  }

  Widget _slider() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.03),
        child: Column(children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
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
        ]));
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button("Прайс и\nподарочные\nсертификаты", "assets/main/6.price.png"),
        _button("Режим работы\nи схема\nпроезда", "assets/main/7.map.png"),
        _button("Зона отдыха \nи детского\nдосуга", "assets/main/8.rest.png"),
      ],
    );
  }

  Widget _button(String text, String assetPath) {
    return GestureDetector(
        onTap: () {
          _openInfoScreen(text);
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Image.asset(
                  assetPath,
                  height: _screenHeight * 0.23,
                  width: _screenWidth * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _openInfoScreen(String text) {
    switch (text) {
      case "Прайс и\nподарочные\nсертификаты":
        {
          _openPriceScreen();
          break;
        }
      case "Режим работы\nи схема\nпроезда":
        {
          _openRegimeScreen();
          break;
        }
      case "Зона отдыха \nи детского\nдосуга":
        {
          _openChillZoneScreen();
          break;
        }
    }
  }

  void _openPriceScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => PriceScreen()));
  }

  void _openChillZoneScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => ChillZoneScreen()));
  }

  void _openRegimeScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => RegimeScreen()));
  }

  Widget _registrationToInstructorButton() {
    return Container(
      width: _screenWidth * 0.9,
      height: _screenHeight * 0.1,
      margin: EdgeInsets.only(top: _screenHeight*0.05),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
        child: InkWell(
            onTap: _openRegistrationToInstructorScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ЗАПИСАТЬСЯ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "на занятие",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ]),
            )),
      ),
    );
  }

  void _openRegistrationToInstructorScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => RegistrationFirstScreen()));
  }

  Widget _infoButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 50.0,
        height: 25,
        margin: EdgeInsets.only(top: 25),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          color: Colors.white,
          child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => AboutUsScreen()));
              },
              child: Center(
                child: Text(
                  "О нас",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              )),
        ),
      ),
      Container(
        height: 25,
        margin: EdgeInsets.only(top: 25, left: 20),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          color: Colors.white,
          child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => CallUsScreen()));
              },
              child: Center(
                child: Text(
                  " Связаться с нами    ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              )),
        ),
      ),
    ]);
  }
}
