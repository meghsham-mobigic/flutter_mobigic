List<String> generateHorizontalMonthGrid(int monthStartsOn, int daysInMonth) {
  const List<String> weekdayLabels = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  List<String> calendarGrid = List<String>.filled(42, '');

  int currentDate = 1;
  int remainingEmptyCells = monthStartsOn % 7;

  for (int i = 0; i < calendarGrid.length;) {
    // Fill first row with weekday labels
    if (i <= 6) {
      calendarGrid[i] = weekdayLabels[i % 7];
    }
    // Fill empty cells before the month starts
    else if (i > 6 && remainingEmptyCells-- > 0) {
      calendarGrid[i] = '';
    }
    // Fill actual days of the month
    else if (i > 6 && currentDate <= daysInMonth) {
      calendarGrid[i] = (currentDate++).toString();
    }

    i++;

    // Restart from position 7 if dates are left and grid is filled
    if (currentDate <= daysInMonth && i == calendarGrid.length) {
      i = weekdayLabels.length;
    }
  }

  // print("Horizontal Month Grid => $calendarGrid");
  return calendarGrid;
}
