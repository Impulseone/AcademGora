import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  final Function _getCode;

  LoginFormWidget(this._getCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 220,
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: [
          _topText(),
          _inputNumberWidget(),
          _textNumberHint(),
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

  Widget _inputNumberWidget() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        child: Row(
          children: [
            Image.asset(
              "assets/auth/e4.png",
              height: 40,
              width: 40,
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(left: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "+7",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                style: TextStyle(fontSize: 20),
                maxLines: 1,
              ),
            )
          ],
        ));
  }

  Widget _textNumberHint() {
    return Container(
        margin: EdgeInsets.only(left: 38),
        child: Text(
          "Номер телефона",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ));
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
