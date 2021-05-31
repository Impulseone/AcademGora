import 'package:academ_gora/screens/account/instructor_profile/instructor_workouts_screen.dart';
import 'package:flutter/material.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({Key key}) : super(key: key);

  @override
  _InstructorProfileScreenState createState() =>
      _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  double _screenHeight;
  double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: _screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/instructor_profile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _instructorPhoto(),
          _redactPhotoButton(),
          _instructorName(),
          _instructorInfo(),
          _redactInstructorInfoButton(),
          _socialNetworksList(),
          _backButton()
        ],
      ),
    ));
  }

  Widget _instructorPhoto() {
    return Container(
        height: _screenHeight * 0.1,
        width: _screenWidth * 0.2,
        child: Image.asset("assets/instructors_list/e_3.png"));
  }

  Widget _redactPhotoButton() {
    return Container(
      width: _screenWidth * 0.6,
      height: _screenHeight * 0.05,
      margin: EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: () {},
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "РЕДАКТИРОВАТЬ ФОТО",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _instructorName() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        "Ярославский Александр",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _instructorInfo() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: _screenHeight * 0.2,
        width: _screenWidth * 0.8,
        child: SingleChildScrollView(
            child: Flex(
          direction: Axis.vertical,
          children: [
            Text(
              "Инструктор по сноуборду",
              style: TextStyle(fontSize: 14),
            )
          ],
        )));
  }

  Widget _redactInstructorInfoButton() {
    return Container(
        child: GestureDetector(
      child: Text(
        "Редактировать информацию о себе",
        style: TextStyle(color: Colors.blue),
      ),
    ));
  }

  Widget _socialNetworksList(){
    return Container(margin: EdgeInsets.only(top: 20), child: Column(children: [
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
      _socialNetworkWidget(),
    ],),);
  }

  Widget _socialNetworkWidget(){
    return Container(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(margin: EdgeInsets.only(right: 15), height: 20, width: 20, child: Image.asset("assets/instructor_profile/3.png"),),
      Container(width: _screenWidth*0.5, child: Text("+79611877192",style: TextStyle(fontWeight: FontWeight.bold),),),
      Container(child: Icon(Icons.open_in_new_outlined),),
    ],),);
  }
  Widget _backButton() {
    return Container(
      width: _screenWidth * 0.6,
      height: _screenHeight * 0.05,
      margin: EdgeInsets.only(top: 25),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openInstructorWorkoutsScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НАЗАД",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }
  void _openInstructorWorkoutsScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => InstructorWorkoutsScreen()),
            (route) => false);
  }
}
