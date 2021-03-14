import 'package:flutter/material.dart';

class AllInstructorsScreenWidget extends StatefulWidget {
  @override
  _AllInstructorsScreenWidgetState createState() =>
      _AllInstructorsScreenWidgetState();
}

class _AllInstructorsScreenWidgetState
    extends State<AllInstructorsScreenWidget> {
  double _screenWidth;
  double _screenHeight;

  int _selectedKindOfSport = 0;

  List<String> _instructors = [
    "Ярославский\nАлександр",
    "Карманова\nЕвгения",
    "Крюкова\nОльга",
    "Трофимов\nПавел",
    "Ярославский\nАлександр",
    "Карманова\nЕвгения",
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
            _arrowButton("assets/all_instructors/5.png", 4, 0, 0),
            _centerWidget(
                _selectedKindOfSport == 0 ? "ГОРНЫЕ ЛЫЖИ" : "СНОУБОРД"),
            _arrowButton("assets/all_instructors/4.png", 0, 4, 1),
          ],
        ),
      ),
    );
  }

  void _checkoutKindOfSport(int value) {
    setState(() {
      _selectedKindOfSport = value;
    });
  }

  Widget _arrowButton(
      String imagePath, double marginLeft, double marginRight, int value) {
    return (_selectedKindOfSport == 0 && value == 0 ||
            _selectedKindOfSport == 1 && value == 1)
        ? Container(
            height: 35,
            width: 35,
            margin: EdgeInsets.only(left: marginLeft, right: marginRight),
          )
        : GestureDetector(
            onTap: () {
              _checkoutKindOfSport(value);
            },
            child: Container(
              height: 35,
              width: 35,
              margin: EdgeInsets.only(left: marginLeft, right: marginRight),
              child: Image.asset(imagePath),
            ));
  }

  Widget _centerWidget(String kindOfSport) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _kindOfSportName(kindOfSport),
          _instructorsListWidget(),
          _backToMainScreenButton()
        ],
      ),
    );
  }

  Widget _kindOfSportName(String name) {
    return Container(
      width: _screenWidth * 0.7,
      height: _screenHeight * 0.05,
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        image: DecorationImage(
          image: AssetImage("assets/all_instructors/1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.blue, fontSize: 20),
      ),
    );
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
                  children: _profileWidgets()),
            )
          ],
        ));
  }

  List<Widget> _profileWidgets() {
    List<Widget> widgets = [];
    for (var i = 0; i < 6; ++i) {
      widgets.add(_profileWidget(i));
    }
    return widgets;
  }

  Widget _profileWidget(int which) {
    return Container(
      child: Column(
        children: [
          Container(
            width: _screenWidth * 0.3,
            height: _screenHeight * 0.11,
            child: Image.asset("assets/all_instructors/2.png"),
          ),
          Text(
            _instructors[which],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
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
                style: TextStyle(fontSize: 10, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
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
            onTap: () => {Navigator.of(context).pop()},
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
