class MonthDays {
  static int totalMonthDates = 31;
  static int datePointer = 1;
  static int monthStarter = 0;

  String giveDate() {
    return (datePointer++).toString();
  }
}

class WeekDays {
  static int dayPointer = 0;

  String giveDay() {
    const List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    if (dayPointer > 6) {
      dayPointer = dayPointer % 7;
    }
    return weekdays[dayPointer++];
  }
}
