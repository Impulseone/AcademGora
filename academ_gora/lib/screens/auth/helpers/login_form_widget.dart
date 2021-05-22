import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFormWidget extends StatelessWidget {
  final Function _getCode;

  LoginFormWidget(this._getCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 120,
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: [
          _topText(),
          _getCodeButton()
        ],
      ),
    );
  }

  Widget _topText() {
    return Container(
      width: 280,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Center(
          child: Text(
        "Вход",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 28),
      )),
    );
  }

  Widget _getCodeButton() {
    return GestureDetector(
        onTap: _getCode,
        child: Container(
          margin: EdgeInsets.only(top: 12),
          width: 200,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Center(
              child: Text(
            "Получить код",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
        ));
  }
}
