import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../registration_parameters_screen.dart';

class HumanInfoWidget extends StatefulWidget {
  final int which;
  final List<Pair> textEditingControllers;
  final RegistrationParametersScreenState registrationParametersScreenState;

  const HumanInfoWidget(this.which, this.textEditingControllers,
      this.registrationParametersScreenState,
      {Key key})
      : super(key: key);

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
        _textFieldWidget(130, 50, TextInputType.name),
        _titleWidget("Возраст"),
        _textFieldWidget(50, 3, TextInputType.number)
      ],
    );
  }

  Widget _numberOfPersonWidget() {
    return Text(
      widget.which.toString(),
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

  Widget _textFieldWidget(
      double width, int maxLength, TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.only(bottom: 3, left: 10),
      height: 30,
      width: width,
      child: TextField(
        onSubmitted: (s) =>
            {widget.registrationParametersScreenState.setState(() {})},
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        controller: maxLength == 3
            ? widget.textEditingControllers[widget.which - 1].right
            : widget.textEditingControllers[widget.which - 1].left,
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 5, bottom: 11, top: 11, right: 5),
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}
