import 'package:academ_gora/model/workout.dart';

class Instructor{
  String id;
  String phone;
  String fio;
  String photoUrl;
  List<Workout> workouts;
  WorkoutsSchedule workoutsSchedule;
}

class WorkoutsSchedule{
    List<DaySchedule> daySchedules;
}

class DaySchedule{
  List<TimeAndStatus> timesAndStatuses;
}

class TimeAndStatus{
  String time;
  WorkoutStatus status;
}

enum WorkoutStatus{
  OPENED,
  TIMEBREAK,
  WORKOUT,
  CLOSED
}