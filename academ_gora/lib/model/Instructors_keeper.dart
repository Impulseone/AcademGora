import 'package:academ_gora/model/instructor.dart';

class InstructorsKeeper {
  static final InstructorsKeeper _instructorsKeeper =
      InstructorsKeeper._internal();

  List<Instructor> instructorsList = [];

  InstructorsKeeper._internal();

  factory InstructorsKeeper() {
    return _instructorsKeeper;
  }

  void updateInstructors(Map instructors){
    instructorsList = [];
    instructors.forEach((key, value) {
      instructorsList.add(Instructor.fromJson(value));
    });
  }

  void clear() {
    instructorsList = [];
  }
}
