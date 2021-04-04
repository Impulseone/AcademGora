class SportType {
  static String snowboard;
  static String skiing;
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
}

class WorkoutSingleton {
  static final WorkoutSingleton _singleton = WorkoutSingleton._internal();

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
    instructorName = null;
    peopleCount = null;
    workoutDuration = null;
    levelOfSkating = null;
    comment = null;
    fio = null;
    age = 0;
  }
}
