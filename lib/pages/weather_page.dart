// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/model/weather_model.dart';
import 'package:todoapp/util/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("7e0ec845e195d0277fd255af54bfb9ee");
  Weather? _weather;

  // fetch weather data
  Future<void> _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      Weather weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null || mainCondition.isEmpty) {
      return "assets/partly_cloudy.json";
    }
    switch (mainCondition.toLowerCase()) {
      case "clouds":
       return "assets/cloudy.json";
      case "snow":
        return "assets/snowy.json";
      case "rain":
        return "assets/rainy.json";
      case "clear":
        return "assets/sunny.json";
      case "few clouds":
        return "assets/partly_cloudyjson";
      default:
        return "assets/partly_cloudy.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    setState(() {
      _weather = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ABE2), Color(0xFF5563DE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: _weather == null
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _weather!.cityName,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${_weather!.temperature.round()} °C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Lottie.asset(
                      getWeatherAnimation(_weather?.mainCondition),
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      _weather!.mainCondition,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),

    );
  }
}