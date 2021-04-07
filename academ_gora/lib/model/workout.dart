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
  String instructorPhoneNumber;
  List<Visitor> visitors = [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workout && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
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
  List<Visitor> visitors = [];

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
    visitors = [];
  }
}

class Visitor {
  String name;
  int age;

  Visitor(this.name, this.age);
}
