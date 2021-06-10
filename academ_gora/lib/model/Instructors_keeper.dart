import 'package:academ_gora/model/instructor.dart';

class InstructorsKeeper {
  static final InstructorsKeeper _instructorsKeeper =
      InstructorsKeeper._internal();

  List<Instructor> instructorsList = [];

  InstructorsKeeper._internal();

  factory InstructorsKeeper() {
    return _instructorsKeeper;
  }

  void updateInstructors(Map instructors) {
    instructorsList = [];
    instructors.forEach((key, value) {
      instructorsList.add(Instructor.fromJson(key, value));
    });
  }

  List<Instructor> findInstructorsByKindOfSport(String kindOfSport) {
    List<Instructor> filtered = [];
    instructorsList.forEach((element) {
      if (element.kindOfSport == kindOfSport) filtered.add(element);
    });
    return filtered;
  }

  Instructor findInstructorByPhoneNumber(String phoneNumber) {
    Instructor instructor;
    instructorsList.forEach((element) {
      if (element.phone == phoneNumber) {
        instructor = element;
      }
    });
    return instructor;
  }

  void clear() {
    instructorsList = [];
  }
}
