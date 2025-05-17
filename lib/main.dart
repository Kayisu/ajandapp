import 'package:flutter/material.dart';
import 'package:todoapp/pages/calendar_page.dart';
import 'package:intl/date_symbol_data_local.dart';  // ← for initializeDateFormatting


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR');
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  CalendarPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
