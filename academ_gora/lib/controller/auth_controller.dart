import 'package:academ_gora/model/user_role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final dbRef = FirebaseDatabase.instance.reference();

  void saveUserRole(String phoneNumber) async {
    String userRole = UserRole.user;
    dbRef.child("Телефоны инструкторов").once().then((value) async {
      (value.value as Map<dynamic, dynamic>).entries.forEach((element) {
        if (element.value == phoneNumber) {
          userRole = UserRole.instructor;
        }
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userRole", userRole);
      _saveUserInDb(userRole);
    });
  }

  void _saveUserInDb(String userRole) {
    dbRef.child("$userRole").once().then((value) {
      bool userExists = false;
      for (var userId in (value.value as Map<dynamic, dynamic>).keys) {
        if (userId == FirebaseAuth.instance.currentUser.uid) userExists = true;
      }
      if (!userExists)
        dbRef
            .child("$userRole/${FirebaseAuth.instance.currentUser.uid}")
            .set({"Телефон": FirebaseAuth.instance.currentUser.phoneNumber});
    });
  }
}
