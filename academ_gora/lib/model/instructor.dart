import 'package:academ_gora/model/workout.dart';

class Instructor {
  String id;
  String phone;
  String name;
  String photoUrl;
  List<Workout> workouts;
  WorkoutsSchedule workoutsSchedule;
  String info;
  String kindOfSport;
  Map<dynamic, dynamic> socialNetworks;
  Map<dynamic, dynamic> schedule;

  static Instructor fromJson(Map<dynamic, dynamic> map) {
    Instructor instructor = Instructor();
    instructor.name = map["ФИО"];
    instructor.phone = map["Телефон"];
    instructor.photoUrl = map["Фото"];
    instructor.info = map["Информация"];
    instructor.socialNetworks = map["Соцсети"];
    instructor.schedule = map["График работы"];
    instructor.kindOfSport = map["Вид спорта"];
    return instructor;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Instructor &&
          runtimeType == other.runtimeType &&
          phone == other.phone;

  @override
  int get hashCode => phone.hashCode;
}

class SocialNetwork {
  String name;
  String url;

  SocialNetwork(this.name, this.url);
}

class WorkoutsSchedule {
  List<DaySchedule> daySchedules;
}

class DaySchedule {
  List<TimeAndStatus> timesAndStatuses;
}

class TimeAndStatus {
  String time;
  WorkoutStatus status;
}

enum WorkoutStatus { OPENED, TIMEBREAK, WORKOUT, CLOSED }
