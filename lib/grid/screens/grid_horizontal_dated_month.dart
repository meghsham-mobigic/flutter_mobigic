import 'package:flutter/material.dart';
import 'package:flutter_mobigic/grid/utils/grid_generator_horizontal.dart';

class HorizontalDatedMonthGrid extends StatefulWidget {
  const HorizontalDatedMonthGrid({
    required this.title,
    required this.weekStartsOn,
    required this.monthStartsOn,
    required this.daysInMonth,
    super.key,
  });

  final String title;
  final int weekStartsOn;
  final int monthStartsOn;
  final int daysInMonth;

  @override
  State<HorizontalDatedMonthGrid> createState() =>
      _HorizontalDatedMonthGridState();
}

class _HorizontalDatedMonthGridState extends State<HorizontalDatedMonthGrid> {
  final List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  late List<String> monthGrid;

  @override
  void initState() {
    super.initState();
    monthGrid = generateHorizontalMonthGrid(
      widget.monthStartsOn,
      widget.daysInMonth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
                children: List.generate(42, (index) {
                  final bool isHeader = index < 7;
                  final String text = monthGrid[index];
                  debugPrint('${text.runtimeType}');
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: isHeader
                          ? Colors.deepPurple[200]
                          : Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: isHeader
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
