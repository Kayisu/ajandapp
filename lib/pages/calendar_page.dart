import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ajandapp/pages/todo_page.dart';

class CalendarPage extends StatefulWidget { // Uygulama açıldığında takvim sayfasını gösteren widget
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now(); // Bugünün tarihini alıyoruz
  DateTime firstDay = DateTime( // Takvimin başlangıç tarihi
    DateTime.now().year - 5,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime lastDay = DateTime( // Takvimin bitiş tarihi
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
                ),
              ),
              child: Column(
                
                children: [
                  const SizedBox(height: 20),
                  TableCalendar( //TableCalendar paketi ile takvim

                  // Takvim stili
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
                    locale: 'tr_TR', //lokalizasyon
                    focusedDay: today,
                    firstDay: firstDay,
                    lastDay: lastDay,
                    availableGestures: AvailableGestures.all, 
                    selectedDayPredicate: (day) => isSameDay(day, today), // Seçili günün bugünkü tarih ile aynı olup olmadığını kontrol ediyoruz
                    onDaySelected: (selectedDay, focusedDay) { // Seçilen günün tıklanma eventi
                      setState(() {
                        today = selectedDay; // Seçilen günü today değişkenine atıyoruz
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => TodoPage(selectedDate: selectedDay), //ilgili tarihe ait TodoPage'e yönlendiriyoruz
                        ),
                      );
                    },
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
