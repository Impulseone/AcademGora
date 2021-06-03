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

  static Workout fromJson(workoutData) {
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
    workout.visitors = _parseVisitors(workoutData["Посетители"]);
    workout.workoutDuration = workoutData["Продолжительность"];
    return workout;
  }

  static List<Visitor> _parseVisitors(Map<dynamic,dynamic> visitors) {
    List<Visitor> visitorsList = [];
    visitors.forEach((key,value) {
        visitorsList.add(Visitor(value["Имя"], value["Возраст"]));
    });
    return visitorsList;
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
  String instructorId;
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
    instructorId = null;
  }
}

class Visitor {
  String name;
  int age;

  Visitor(this.name, this.age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Visitor &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age;

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
