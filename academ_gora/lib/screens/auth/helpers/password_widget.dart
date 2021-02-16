import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordWidget extends StatefulWidget {
  final Function _getCode;
  final Function _back;
  final String _number;

  PasswordWidget(this._getCode, this._back, this._number);

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState(_getCode,_back,_number);
}

class _PasswordWidgetState extends State<PasswordWidget> {
  final Function _getCode;
  final Function _back;
  final String _number;

  FocusNode _myFocusNode1 = FocusNode();
  FocusNode _myFocusNode2 = FocusNode();
  FocusNode _myFocusNode3 = FocusNode();
  FocusNode _myFocusNode4 = FocusNode();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  _PasswordWidgetState(this._getCode, this._back, this._number);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 250,
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: [
          _topText(),
          _inputNumberWidget(),
          _textNumberHint(),
          _getCodeButton(),
          _backAndResendButton()
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
            _numberTextField(1, _myFocusNode1, _controller1),
            _numberTextField(2, _myFocusNode2, _controller2),
            _numberTextField(3, _myFocusNode3, _controller3),
            _numberTextField(4, _myFocusNode4, _controller4),
          ],
        ));
  }

  Widget _numberTextField(int id, FocusNode focusNode,
      TextEditingController textEditingController) {
    return Container(
      width: 50,
      margin: EdgeInsets.only(left: 13),
      child: TextField(
        onChanged: (s) {
          onTextChanged(id);
        },
        controller: textEditingController,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
            border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        )),
        style: TextStyle(fontSize: 20),
        maxLines: 1,
      ),
    );
  }

  void onTextChanged(int id) {
    switch (id) {
      case 1:
        if (_controller1.text.isNotEmpty) {
          _myFocusNode2.requestFocus();
        }
        break;
      case 2:
        if (_controller2.text.isNotEmpty) {
          _myFocusNode3.requestFocus();
        }
        break;
      case 3:
        if (_controller3.text.isNotEmpty) {
          _myFocusNode4.requestFocus();
        }
        break;
      case 4:
        break;
    }
  }

  Widget _textNumberHint() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          "На номер $_number \nвыслан пароль",
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
            "Подтвердить",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
        ));
  }

  Widget _backAndResendButton() {
    return Container(
        margin: EdgeInsets.only(top: 15),
        width: 200,
        child: Row(
          children: [
            GestureDetector(
                onTap: _back,
                child: Image.asset(
                  "assets/auth/e6.png",
                  width: 15,
                  height: 15,
                )),
            Container(
                margin: EdgeInsets.only(left: 60),
                child: Text(
                  "Отправить снова",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ))
          ],
        ));
  }
}
