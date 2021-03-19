import 'package:academ_gora/screens/instructor_profile/instructor_profile_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';

class AllInstructorsScreen extends StatefulWidget {
  @override
  _AllInstructorsScreenState createState() => _AllInstructorsScreenState();
}

class _AllInstructorsScreenState extends State<AllInstructorsScreen> {
  double _screenWidth;
  double _screenHeight;

  String _selectedKindOfSport = "ГОРНЫЕ ЛЫЖИ";

  List<String> _snowboardInstructors = [
    "Ярославский\nАлександр",
    "Карманова\nЕвгения",
    "Крюкова\nОльга",
    "Трофимов\nПавел",
    "Ярославский\nАлександр",
    "Карманова\nЕвгения",
  ];

  List<String> _skiesInstructors = [
    "Ярославский\nАлександр",
    "Карманова\nЕвгения",
    "Крюкова\nОльга",
    "Трофимов\nПавел",
    "Крюкова\nОльга",
    "Трофимов\nПавел",
    "Иванов\nИван",
    "Петров\nПетр",
  ];

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/all_instructors/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _instructorsList(),
          ],
        ),
      ),
    );
  }

  void _checkoutKindOfSport(String value) {
    setState(() {
      _selectedKindOfSport = value;
    });
  }

  Widget _instructorsList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _kindOfSportButton("ГОРНЫЕ ЛЫЖИ"),
          _kindOfSportButton("СНОУБОРД"),
          _instructorsListWidget(),
          _backToMainScreenButton()
        ],
      ),
    );
  }

  Widget _kindOfSportButton(String name) {
    return GestureDetector(
        onTap: () {
          if (_selectedKindOfSport != name)
            _checkoutKindOfSport(_selectedKindOfSport == "ГОРНЫЕ ЛЫЖИ"
                ? "СНОУБОРД"
                : "ГОРНЫЕ ЛЫЖИ");
        },
        child: Container(
          width: _checkKindOfSport(name)
              ? _screenWidth * 0.75
              : _screenWidth * 0.7,
          height: _checkKindOfSport(name)
              ? _screenHeight * 0.06
              : _screenHeight * 0.05,
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: _checkKindOfSport(name) ? Colors.blue : Colors.white),
          child: Text(
            name,
            style: TextStyle(
                color: _checkKindOfSport(name) ? Colors.white : Colors.blue,
                fontSize: _checkKindOfSport(name)
                    ? _screenHeight * 0.034
                    : _screenHeight * 0.03),
          ),
        ));
  }

  bool _checkKindOfSport(String name) {
    return (name == "ГОРНЫЕ ЛЫЖИ" && _selectedKindOfSport == name) ||
        (name == "СНОУБОРД" && _selectedKindOfSport == name);
  }

  Widget _instructorsListWidget() {
    return Container(
        height: _screenHeight * 0.7,
        width: _screenWidth * 0.78,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: CustomScrollView(
          primary: false,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverGrid.count(
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: _profileWidgets(_selectedKindOfSport == "СНОУБОРД"
                      ? _snowboardInstructors
                      : _skiesInstructors)),
            )
          ],
        ));
  }

  List<Widget> _profileWidgets(List<String> instructors) {
    List<Widget> widgets = [];
    for (var i = 0; i < instructors.length; ++i) {
      widgets.add(_profileWidget(i, instructors));
    }
    return widgets;
  }

  Widget _profileWidget(int which, List<String> instructors) {
    return Container(
      child: Column(
        children: [
          Container(
            width: _screenWidth * 0.28,
            height: _screenHeight * 0.1,
            child: Image.asset("assets/all_instructors/2.png"),
          ),
          Text(
            instructors[which],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          ExpandTapWidget(
            tapPadding: EdgeInsets.all(50),
            onTap: () => _openInstructorProfileScreen(instructors[which]),
            child: Container(
              width: _screenWidth * 0.3,
              height: _screenHeight * 0.03,
              margin: EdgeInsets.only(top: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage("assets/all_instructors/1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                "ОТКРЫТЬ ПРОФИЛЬ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 8, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openInstructorProfileScreen(String instructorName) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => InstructorProfileScreen(
              instructorName,
              screenHeight: _screenHeight,
              screenWidth: _screenWidth,
            )));
  }

  Widget _backToMainScreenButton() {
    return Container(
      width: _screenWidth * 0.4,
      height: _screenHeight * 0.05,
      margin: EdgeInsets.only(top: 18),
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
