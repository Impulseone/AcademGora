class TimesController {
  var _times = {
    "9:00": 0,
    "9:30": 1,
    "10:00": 2,
    "10:30": 3,
    "11:00": 4,
    "11:30": 5,
    "12:00": 6,
    "12:30": 7,
    "13:00": 8,
    "13:30": 9,
    "14:00": 10,
    "14:30": 11,
    "15:00": 12,
    "15:30": 13,
    "16:00": 14,
    "16:30": 15,
    "17:00": 16,
    "17:30": 17,
    "18:00": 18,
    "18:30": 19,
    "19:00": 20,
    "19:30": 21,
    "20:00": 22,
  };

  String getTimeByValue(int timeValue) {
    String time = "";
    _times.forEach((key, value) {
      if (value == timeValue) {
        time = key;
      }
    });
    return time;
  }

  Map<String, dynamic> setTimesStatus(
      String from, int duration, String status) {
    Map<String, dynamic> timesStatus = {};
    int fromPriority = _times[from];
    if (duration == 1) {
      timesStatus.putIfAbsent(getTimeByValue(fromPriority), () => status);
      if (fromPriority != 0)
        timesStatus.putIfAbsent(getTimeByValue(fromPriority - 1), () => status);
      if (fromPriority != _times.length)
        timesStatus.putIfAbsent(getTimeByValue(fromPriority + 1), () => status);
    }
    if (duration == 2) {
      timesStatus.putIfAbsent(getTimeByValue(fromPriority), () => status);
      if (fromPriority != 0)
        timesStatus.putIfAbsent(getTimeByValue(fromPriority - 1), () => status);
      if (fromPriority != _times.length) {
        timesStatus.putIfAbsent(getTimeByValue(fromPriority + 1), () => status);
        timesStatus.putIfAbsent(getTimeByValue(fromPriority + 2), () => status);
        timesStatus.putIfAbsent(getTimeByValue(fromPriority + 3), () => status);
      }
    }
    return timesStatus;
  }

  get times => _times;
}
