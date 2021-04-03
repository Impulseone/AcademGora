import 'dart:async';

import 'package:academ_gora/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:quiver/async.dart';

class SMSCodeWidget extends StatefulWidget {
  final Function _openMainScreen;
  final Function _back;
  final String _number;
  final AuthBloc authBloc;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SMSCodeWidget(this._openMainScreen, this._back, this._number, this.authBloc,
      this.scaffoldKey);

  @override
  _SMSCodeWidgetState createState() =>
      _SMSCodeWidgetState(_openMainScreen, _back, _number);
}

class _SMSCodeWidgetState extends State<SMSCodeWidget> {
  final Function _openMainScreen;
  final Function _back;
  final String _number;

  TextEditingController _pinEditingController = TextEditingController();
  bool _enable = true;
  bool _cursorEnable = true;

  String _verificationId;

  Timer _timer;
  int _currentTimerValue = 60;
  bool _timerWorking;

  _SMSCodeWidgetState(this._openMainScreen, this._back, this._number);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    _listenSmsCodeInfo(context);
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
          _buildPinInputTextFieldExample(),
          _textNumberHint(),
          _applyCodeButton(),
          _backAndResendButtons()
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

  Widget _textNumberHint() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          "На номер $_number \nвыслан пароль",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ));
  }

  Widget _applyCodeButton() {
    return GestureDetector(
        onTap: _signInWithSmsCode,
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

  Widget _backAndResendButtons() {
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
            GestureDetector(
                onTap: _resendCode,
                child: Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(
                      "Отправить снова($_currentTimerValue)",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    )))
          ],
        ));
  }

  Widget _buildPinInputTextFieldExample() {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Center(
          child: SizedBox(
            height: 50.0,
            child: PinInputTextField(
              pinLength: 6,
              decoration: UnderlineDecoration(
                colorBuilder: PinListenColorBuilder(Colors.blue, Colors.grey),
              ),
              controller: _pinEditingController,
              textInputAction: TextInputAction.go,
              enabled: _enable,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.characters,
              onSubmit: (pin) {
                _signInWithSmsCode();
              },
              enableInteractiveSelection: false,
              cursor: Cursor(
                width: 2,
                color: Colors.lightBlue,
                radius: Radius.circular(1),
                enabled: _cursorEnable,
              ),
            ),
          ),
        ));
  }

  void _signInWithSmsCode() async {
    try {
      widget.authBloc
          .authorizeWithSMSCode(_verificationId, _pinEditingController.text);
      _openMainScreen();
    } catch (e) {
      print("Failed to sign in: " + e.toString());
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          content:
              Text('Ошибка авторизации(${e.toString()}), попробуйте позднее.'),
        ),
      );
    }
  }

  void _listenSmsCodeInfo(BuildContext context) {
    widget.authBloc.verificationIdController.stream.listen((event) {
      if (event != null) _verificationId = event;
    });
  }

  void _resendCode() {
    if (!_timerWorking) {
      _startTimer();
      widget.authBloc.verifyPhone(_number);
      widget.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text('Код выслан повторно'),
        ),
      );
    }
  }

  void _startTimer() {
    _currentTimerValue = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentTimerValue == 0) {
          _timerWorking = false;
          setState(() {
            timer.cancel();
          });
        } else {
          _timerWorking = true;
          setState(() {
            _currentTimerValue--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
