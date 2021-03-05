class RegToInstructorData{
  String instructorName;
  DateTime date;
  int time;


  RegToInstructorData(this.instructorName, this.date, this.time);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegToInstructorData &&
          runtimeType == other.runtimeType &&
          instructorName == other.instructorName &&
          date == other.date &&
          time == other.time;

  @override
  int get hashCode => instructorName.hashCode ^ date.hashCode ^ time.hashCode;
}