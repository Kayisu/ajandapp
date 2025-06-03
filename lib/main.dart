import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todoapp/pages/home_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter uygulamasının başlatılmasını bekler
  await initializeDateFormatting('tr_TR', null); //Lokalizasyon için Türkçe tarih formatlarını başlatır (Ay isimleri, gün isimleri vs.)
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeBar(), // Ana sayfa olarak HomeBar widget'ını kullanır
      theme: ThemeData(primarySwatch: Colors.deepPurple), // Uygulamanın genel temasını belirler
    );
  }
}
