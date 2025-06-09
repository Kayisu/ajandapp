// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ajandapp/model/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'; //Hava durumu API'ı
  final String API_KEY; // OpenWeatherMap API keyi

  WeatherService(this.API_KEY);

  Future<Weather> getWeather(String cityName) async { // Belirtilen şehir için hava durumu verisini alır
    final response = await http.get( // HTTP GET isteği ile hava durumu verisini alır
      Uri.parse('$BASE_URL?q=$cityName&appid=$API_KEY&units=metric&lang=tr'), // API URL'si
    );

    if (response.statusCode == 200) { // Eğer istek başarılı ise
      return Weather.fromJson(jsonDecode(response.body)); // JSON verisini Weather modeline çevirir
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');  //Hata ayıklama
    }
  }

  Future<String> getCurrentCity() async { 
    // Kullanıcının konumuna izin verilip verilmediğini kontrol eder
    LocationPermission permission = await Geolocator.checkPermission(); 
    if (permission == LocationPermission.denied) { // Eğer izin verilmemişse
      permission = await Geolocator.requestPermission(); // Tekrar izin ister
    }

    
    Position position = await Geolocator.getCurrentPosition( // Kullanıcının mevcut konumunu alır
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high), // Yüksek doğrulukta konum alır
    );

    // konumu yer işareti nesnelerinin bir listesine dönüştür
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    //ilk yer işaretinden şehir adını çıkarır
    String? city = placemarks[0].locality; //nullable city 
    // Eğer şehir adı null veya boş ise, yer işaretinden idari bölge adını alır

    if (city == null || city.isEmpty) { 
      city = placemarks[0].administrativeArea; // Eğer şehir adı boş ise, idari bölge adını kullanır (Türkiye için idari bölge adı genellikle il adı, bunu hata olmaması için ekledik)
    }

    return city ?? ""; // Eğer şehir adı hâlâ null ise boş string döner
  }
}
