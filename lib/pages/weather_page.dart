// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ajandapp/model/weather_model.dart';
import 'package:ajandapp/util/weather_service.dart';

class WeatherPage extends StatefulWidget { // Hava durumu sayfasını gösteren widget
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("YOUR API KEY");  //api key
  Weather? _weather; //nullable weather nesnesi

  Future<void> _fetchWeather() async { // asenkron metotla hava durumu verisini getiriyoruz
    String cityName = await _weatherService.getCurrentCity();  // getCurrentCity fonksiyonundan şehir ismini alıyoruz
    try {
      Weather weather = await _weatherService.getWeather(cityName); // getWeather fonksiyonundan hava durumu verisini alıyoruz
      setState(() { // setState ile widget'ı ilgili hava durumu verisi ile güncelliyoruz
        _weather = weather;
      });
    } catch (e) { // hata ayıklama
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) { // hava durumu animasyonunu döndüren metot
    if(mainCondition == null || mainCondition.isEmpty) { // eğer mainCondition null veya boş ise varsayılan animasyonu döndür
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
  void initState() { // widget ilk kez çağrıldığında 
    super.initState();
    _fetchWeather(); // hava durumu verisini çekiyoruz
    setState(() {
      _weather = null; // başlangıçta hava durumu verisi null 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Linear gradient arka plan
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ABE2), Color(0xFF5563DE)],
            begin: Alignment.topCenter, //
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center( 
          child: _weather == null // eğer hava durumu verisi hâlâ null ise yükleniyor animasyonu gösterir
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Column( // hava durumu verisi alındığında gösterilecek widget'lar
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( // şehir ismi stili
                      _weather!.cityName,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text( // sıcaklık 
                      '${_weather!.temperature.round()} °C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Lottie.asset( // Lottie paketi ile hava durumu animasyonu
                      getWeatherAnimation(_weather?.mainCondition),
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    Text( // hava durumu açıklaması
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