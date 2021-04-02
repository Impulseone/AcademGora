import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
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
      loggedInController.sink.add(true);
    } else {
      loggedInController.sink.add(false);
    }
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
      if (value.user != null)
        loggedInController.sink.add(true);
      else
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

  void dispose() {
    verificationIdController.close();
    loggedInController.close();
    errorController.close();
  }
}
