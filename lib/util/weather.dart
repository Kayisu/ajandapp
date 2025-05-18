import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todoapp/model/weather_model.dart';

class WeatherServices {

  fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=7e0ec845e195d0277fd255af54bfb9ee&units=metric'),
    );

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}