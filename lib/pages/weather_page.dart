import 'package:flutter/material.dart';
import 'package:todoapp/model/weather_model.dart';
import 'package:todoapp/util/weather_service.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

// api key
final _weatherService = WeatherService("7e0ec845e195d0277fd255af54bfb9ee");
Weather? _weather;

// fetch weather data
_fetcHWeather() async {
  String cityName = await _weatherService.getCurrentCity();

  try {
  Weather weather = await _weatherService.getWeather(cityName);
  setState(() {
    _weather = weather;
  });
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}

//Weather animations

@override
void initState() {
  super.initState();
  _fetcHWeather();
  // set the state to loading
  setState(() {
    _weather = null;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "Loading...",),

          Text('${_weather?.temperature.round()} °C'),
        ],
      ),)

    );
  }
}