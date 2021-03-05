import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HumanInfoWidget extends StatefulWidget {
  @override
  _HumanInfoWidgetState createState() => _HumanInfoWidgetState();
}

class _HumanInfoWidgetState extends State<HumanInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _numberOfPersonWidget(),
        _titleWidget("Имя"),
        _textFieldWidget(130, TextInputType.name),
        _titleWidget("Возраст"),
        _textFieldWidget(50, TextInputType.number)
      ],
    );
  }

  Widget _numberOfPersonWidget() {
    return Text(
      "1",
      style: TextStyle(
          color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _titleWidget(String text) {
    return Container(
        margin: EdgeInsets.only(left: 8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.blue),
        ));
  }

  Widget _textFieldWidget(double width, TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.only(bottom: 3, left: 10),
      height: 30,
      width: width,
      child: TextField(
        keyboardType: textInputType,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}
