import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  PublishSubject<String> verificationIdController = PublishSubject<String>();

  Future<void> verifyPhone(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        timeout: const Duration(seconds: 15),
        verificationFailed: _verificationFailed,
        codeSent: _smsSent,
        codeAutoRetrievalTimeout: _autoRetrievalTimeout);
  }

  void _verificationCompleted(AuthCredential authResult) async {
    UserCredential firebaseResult =
    await FirebaseAuth.instance.signInWithCredential(authResult);
    if (firebaseResult.additionalUserInfo.isNewUser) {
      print("---------------------------");
      print(firebaseResult.additionalUserInfo.isNewUser);
      print("true");
      print("---------------------------");
      // RegisterUser();
    } else {
      // AuthService().signIn(authResult);
      print("---------------------------");
      print(firebaseResult.additionalUserInfo.isNewUser);
      print("---------------------------");
    }
  }

  void _verificationFailed(FirebaseAuthException authException) {
    print(authException);
    // if (authException.code == 'network-request-failed') {
    //   _scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.fixed,
    //       backgroundColor: Color.fromRGBO(244, 67, 54, 1),
    //       content: Text('Предоставленный номер телефона недействителен'),
    //     ),
    //   );
    // } else if (authException.code == 'too-many-requests') {
    //   _scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.fixed,
    //       backgroundColor: Color.fromRGBO(244, 67, 54, 1),
    //       content: Text(
    //           'Мы заблокировали все запросы с этого устройства из-за необычной активности. Попробуйте позже.'),
    //     ),
    //   );
    // }
  }

  void _smsSent(String verId, [int forceResend]) {
    verificationIdController.sink.add(verId);
  }

  void _autoRetrievalTimeout(String verId) {
    verificationIdController.sink.add(verId);
  }

  void dispose(){
    verificationIdController.close();
  }
}