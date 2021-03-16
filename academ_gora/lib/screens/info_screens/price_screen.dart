import 'package:flutter/material.dart';

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
                image: AssetImage("assets/info_screens/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [_priceTitle(), _table()],
            )));
  }

  Widget _priceTitle() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.1),
      child: Text("ПРАЙС"),
    );
  }

  Widget _table() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            _tableRow(),
            _tableRow()
          ],
        ));
  }

  TableRow _tableRow(){
    return TableRow(
      children: <Widget>[
        Container(
          height: 32,
          color: Colors.white,
          child: Text("Наименование услуги"),
        ),
        Container(
          height: 32,
          color: Colors.white,
          child: Text("1-й час"),
        ),
        Container(
          height: 32,
          color: Colors.white,
          child: Text("Целый день"),
        ),
      ],
    );
  }
}
