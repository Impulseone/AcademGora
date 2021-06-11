import 'package:firebase_database/firebase_database.dart';

class FirebaseRequestsController {
  void addListener(String path, Function function) {
    FirebaseDatabase.instance
        .reference()
        .child(path)
        .onChildAdded
        .listen(function);
    FirebaseDatabase.instance
        .reference()
        .child(path)
        .onChildChanged
        .listen(function);
    FirebaseDatabase.instance
        .reference()
        .child(path)
        .onChildMoved
        .listen(function);
    FirebaseDatabase.instance
        .reference()
        .child(path)
        .onChildRemoved
        .listen(function);
  }

  void send(String path, var map) {
    FirebaseDatabase.instance.reference().child(path).set(map);
  }

  Future<void> update(String path, var map) async {
    FirebaseDatabase.instance.reference().child(path).update(map);
  }

  Future<Map> get(String path) async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.reference().child(path).once();
    return dataSnapshot.value as Map<dynamic, dynamic>;
  }

  Future<void> delete(String path) async {
    return FirebaseDatabase.instance.reference().child(path).remove();
  }
}
