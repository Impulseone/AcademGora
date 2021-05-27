import 'package:firebase_database/firebase_database.dart';

void deleteRegistrationDatesInPast(
    String userRole, String userId, String dateString) {
  FirebaseDatabase.instance
      .reference()
      .child("$userRole/$userId/График работы/$dateString")
      .remove();
}