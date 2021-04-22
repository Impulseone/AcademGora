import 'package:firebase_database/firebase_database.dart';

class FirebaseController{
  void create(String path, var map){
    FirebaseDatabase.instance.reference().child(path).set(map);
  }
}