import 'package:academ_gora/model/user_role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  final dbRef = FirebaseDatabase.instance.reference();

  PublishSubject<String> verificationIdController = PublishSubject<String>();
  BehaviorSubject<bool> loggedInController = BehaviorSubject<bool>();
  PublishSubject<String> errorController = PublishSubject();

  ValueObservable<bool> get isUserLoggedIn {
    _checkUserLoggedIn();
    return loggedInController.stream;
  }

  void _checkUserLoggedIn() async {
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser != null) {
      saveUserRole(FirebaseAuth.instance.currentUser.phoneNumber);
      loggedInController.sink.add(true);
    } else {
      loggedInController.sink.add(false);
    }
  }

  void authorizeWithSMSCode(String verificationId, String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final User user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    print("Successfully signed in UID: ${user.uid}");
    saveUserRole(user.phoneNumber);
  }

  Future<void> verifyPhone(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        timeout: Duration(seconds: 60),
        verificationFailed: _verificationFailed,
        codeSent: _smsSent,
        codeAutoRetrievalTimeout: _autoRetrievalTimeout);
  }

  void _verificationCompleted(AuthCredential authResult) async {
    await FirebaseAuth.instance.signInWithCredential(authResult).then((value) {
      if (value.user != null) {
        saveUserRole(value.user.phoneNumber);
        loggedInController.sink.add(true);
      } else
        errorController.sink.add("User is null");
    }).catchError((e) {
      errorController.sink.add(e);
    });
  }

  void _verificationFailed(FirebaseAuthException authException) {
    print(authException.message);
    errorController.sink.add(authException.message);
  }

  void _smsSent(String verId, [int forceResend]) {
    verificationIdController.sink.add(verId);
  }

  void _autoRetrievalTimeout(String verId) {
    verificationIdController.sink.add(verId);
  }

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
      print("UserRole: $userRole");
      _saveUserInDb(userRole);
    });
  }

  void _saveUserInDb(String userRole) {
    String child = "";
    switch (userRole) {
      case UserRole.user:
        {
          child = "Пользователи";
        }
        return;
      case UserRole.instructor:
        {
          child = "Инструкторы";
        }
        return;
      case UserRole.administrator:
        {
          child = "Администраторы";
        }
        return;
    }
    dbRef
        .child("$child/${FirebaseAuth.instance.currentUser.uid}")
        .once()
        .then((value) {
      if (value == null) {
        dbRef
            .child("$child")
            .set("${FirebaseAuth.instance.currentUser.uid}");
      }
    });
  }

  bool checkIsInstructor(Map<String, dynamic> phones, String phoneNumber) {
    phones.entries.forEach((element) {
      if (element.value == phoneNumber) return true;
    });
    return false;
  }

  void dispose() {
    verificationIdController.close();
    loggedInController.close();
    errorController.close();
  }
}
