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
  int levelOfSkating;
  String comment;
  String instructorPhoneNumber;
  String userPhoneNumber;
  List<Visitor> visitors = [];

  static Workout fromJson(workoutData){
    Workout workout = Workout();
    workout.id = workoutData["id"];
    workout.date = workoutData["Дата"];
    workout.from = workoutData["Время"];
    workout.instructorName = workoutData["Инструктор"];
    workout.instructorPhoneNumber = workoutData["Телефон инструктора"];
    workout.userPhoneNumber = workoutData["Телефон"];
    workout.peopleCount = workoutData["Количество человек"];
    workout.comment = workoutData["Комментарий"];
    workout.sportType = workoutData["Вид спорта"];
    workout.levelOfSkating = workoutData["Уровень катания"];
    List<Visitor> visitors = [];
    for (var visitorMap in (workoutData["Посетители"] as Map<dynamic,dynamic>).values) {
      if (visitorMap != null)
        visitors.add(Visitor(visitorMap["Имя"], visitorMap["Возраст"]));
    }
    workout.visitors = visitors;
    workout.workoutDuration = workoutData["Продолжительность"];
    return workout;
  }

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
  int levelOfSkating;
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
