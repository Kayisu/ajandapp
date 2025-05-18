import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime firstDay = DateTime(
    DateTime.now().year - 10,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime lastDay = DateTime(
    DateTime.now().year + 10,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 196, 174, 233),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  TableCalendar(
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      weekendStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      outsideTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 131, 131, 131),
                        fontSize: 15,
                      ),
                    ),
                    locale: 'tr_TR',
                    focusedDay: today,
                    firstDay: firstDay,
                    lastDay: lastDay,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
