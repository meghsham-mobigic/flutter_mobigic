import 'package:flutter/material.dart';
import 'package:flutter_mobigic/grid/utils/grid_generator_vertical.dart';
class VerticalDatedMonthGrid extends StatefulWidget {

  const VerticalDatedMonthGrid({
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
  State<VerticalDatedMonthGrid> createState() => _VerticalDatedMonthGridState();
}

class _VerticalDatedMonthGridState extends State<VerticalDatedMonthGrid> {
  final List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  late List<dynamic> monthGrid;

  @override
  void initState() {
    super.initState();
    monthGrid = generateVerticalMonthGrid(
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
                crossAxisCount: 6,
                childAspectRatio: 1.5,
                children: List.generate(42, (index) {
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: index % 6 == 0
                          ? Colors.deepPurple[200]
                          : Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        monthGrid[index].toString(),
                        style: TextStyle(
                          fontWeight: index % 6 == 0
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
