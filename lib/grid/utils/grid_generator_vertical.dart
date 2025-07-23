// firstWeekday (0-6) denotes the weekday on which the 1st of the month falls
// totalDays (28, 29, 30, 31) denotes the number of days in the month
List<dynamic> generateVerticalMonthGrid(int firstWeekday, int totalDays) {
  // Labels for weekdays (to be placed in the first column)
  final List<String> weekdayLabels = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // Array to store the vertical calendar grid (7 rows x 6 columns = 42 cells)
  List<dynamic> verticalCalendarGrid = List.filled(42, "");

  int currentDate = 1; // Pointer to track the current date being inserted
  int remainingEmptyCells =
      firstWeekday; // Number of leading empty cells before the 1st day starts
  int overflowDays =
      totalDays -
      (35 -
          firstWeekday); // Days that don’t fit in 5 columns and wrap to the top

  for (int i = 0; i < verticalCalendarGrid.length; i++) {
    // Column index (0 to 6) – horizontal movement (Sun to Sat)
    int colPosition = i % 7;

    // Row index (0 to 5) – vertical movement (Week 1 to Week 6)
    int rowPosition = (i / 7)
        .toInt(); // Converts division result to int (drops decimal)

    // Index to insert into the 1D vertical grid
    int gridPosition = (colPosition * 6) + rowPosition;

    // Fill the first row with weekday labels
    if (rowPosition == 0) {
      verticalCalendarGrid[gridPosition] = weekdayLabels[colPosition];
    }
    // Fill empty cells before the 1st of the month, possibly with overflow dates
    else if (remainingEmptyCells > 0) {
      if (overflowDays > 0) {
        verticalCalendarGrid[gridPosition] = totalDays - overflowDays + 1;
        overflowDays--;
      }
      remainingEmptyCells--;
    }
    // Fill actual dates of the current month
    else if (currentDate <= totalDays) {
      verticalCalendarGrid[gridPosition] = currentDate++;
    }
  }

  // print("Vertical Month Grid => $verticalCalendarGrid");
  return verticalCalendarGrid;
}
