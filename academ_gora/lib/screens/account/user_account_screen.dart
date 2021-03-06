import 'package:flutter/material.dart';

class UserAccountScreen extends StatefulWidget {
  @override
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/account/0_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _topAccountInfo(),
        ],
      ),
    ));
  }

  Widget _topAccountInfo() {
    return Container(
        margin: EdgeInsets.only(top: 50, right: 10),
        child: Column(
          children: [_accountTextWidget(), _phoneTextWidget(), _exitButton()],
        ));
  }

  Widget _accountTextWidget() {
    return Container(
        alignment: Alignment.topRight,
        child: Text(
          "Личный кабинет",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ));
  }

  Widget _phoneTextWidget() {
    return Container(
        margin: EdgeInsets.only(top: 6),
        alignment: Alignment.topRight,
        child: Text(
          "+7 999 333 38 42",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Widget _exitButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "ВЫЙТИ",
          style: TextStyle(color: Colors.white),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
            height: 20, width: 20, child: Image.asset("assets/account/e1.png"))
      ],
    ));
  }
}
