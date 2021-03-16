import 'package:academ_gora/screens/info_screens/price_info.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double screenWidth;
  double screenHeight;

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
                image: AssetImage("assets/info_screens/prices/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [_priceTitle(), _table(), _info(), _openMainScreenButton()],
            )));
  }

  Widget _priceTitle() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.04),
      child: Text(
        "ПРАЙС",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _table() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Table(
          border: TableBorder.all(color: Colors.white, width: 2),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            _tableRow(
              "Наименование услуги",
              "1-й час",
              "Целый день",
              color: Colors.white,
            ),
            _tableRow("Горные лыжи или\nсноуборд", "400", "1100"),
            _tableRow("Беговые лыжи", "300", "750"),
            _tableRow("Детские горные лыжи\nили сноуборд", "300", "750"),
            _tableRow("Разовый подъем", "50", "50"),
            _tableRow("Абонемент на кресельный подъемник", "400", "1100"),
            _tableRow("Лыжи или сноуборд\nбез ботинок, ботинки\nотдельно",
                "300", "950"),
            _tableRow("Въезд на территорию\n(1 въезд)", "100", "100"),
          ],
        ));
  }

  TableRow _tableRow(String text1, String text2, String text3,
      {Color color = Colors.transparent, double leftPadding = 10}) {
    return TableRow(
      children: <Widget>[
        _textInTable(text1, Alignment.centerLeft,
            color: color, leftPadding: leftPadding),
        _textInTable(text2, Alignment.center, color: color),
        _textInTable(text3, Alignment.center, color: color),
      ],
    );
  }

  Widget _textInTable(String text, Alignment alignment,
      {Color color = Colors.transparent, double leftPadding = 0}) {
    return Container(
        alignment: alignment,
        padding: EdgeInsets.only(left: leftPadding, top: 5, bottom: 5),
        color: color,
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)));
  }

  Widget _info() {
    return Container(
      height: screenHeight * 0.29,
      width: screenWidth * 0.9,
      margin: EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Text(
          PriceInfo.getPriceInfo(),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _openMainScreenButton() {
    return Container(
      width: screenWidth * 0.6,
      height: screenHeight * 0.065,
      margin: EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openMainScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НА ГЛАВНУЮ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
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
}
