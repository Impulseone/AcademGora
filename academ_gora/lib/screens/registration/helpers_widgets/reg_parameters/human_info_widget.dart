import 'package:flutter/material.dart';

class HumanInfoWidget extends StatefulWidget {
  @override
  _HumanInfoWidgetState createState() => _HumanInfoWidgetState();
}

class _HumanInfoWidgetState extends State<HumanInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("1"),
        Text("Имя"),
        Container(height: 30, width: 100, child: TextField()),
        Text("Возраст"),
        Container(height: 30, width: 100, child: TextField()),
      ],
    );
  }
}
