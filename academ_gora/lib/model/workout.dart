class SportType {
  static const String snowboard = "Сноуборд";
  static const String skiing = "Горные лыжи";
}

class Workout {
  String id;
  String sportType;
  String date;
  String from;
  String to;
  String instructorName;
  int peopleCount;
  int workoutDuration;
  String levelOfSkating;
  String comment;
  String fio;
  int age;
  String instructorPhoneNumber;
}

class WorkoutSingleton {
  static final WorkoutSingleton _singleton = WorkoutSingleton._internal();

  String id;
  String sportType;
  String date;
  String from;
  String to;
  int peopleCount;
  int workoutDuration;
  String levelOfSkating;
  String comment;
  String fio;
  int age;
  String instructorName;
  String instructorPhoneNumber;

  factory WorkoutSingleton() {
    return _singleton;
  }

  WorkoutSingleton._internal();

  void clear() {
    id = null;
    sportType = null;
    date = null;
    from = null;
    to = null;
    peopleCount = null;
    workoutDuration = null;
    levelOfSkating = null;
    comment = null;
    fio = null;
    age = 0;
    instructorName = null;
    instructorPhoneNumber = null;
  }
}
