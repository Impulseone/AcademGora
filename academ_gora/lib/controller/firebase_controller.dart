import 'package:firebase_database/firebase_database.dart';

class FirebaseController {
  void send(String path, var map) {
    FirebaseDatabase.instance.reference().child(path).set(map);
  }

  Future<void> update(String path, var map)async {
    FirebaseDatabase.instance.reference().child(path).update(map);
  }

  Future<Map> get(String path) async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.reference().child(path).once();
    return dataSnapshot.value as Map<dynamic, dynamic>;
  }

  void delete(String path) {
    FirebaseDatabase.instance
        .reference()
        .child(path)
        .remove();
  }
}
