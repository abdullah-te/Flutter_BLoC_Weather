import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/const/const.dart';

class WeatherRepository {
  final http.Client httpClient;


  WeatherRepository({required this.httpClient}): assert(httpClient != null);
  Future<int> getLocationIdFromCity(String city) async {
  print("1");
    final response = await httpClient.get(Uri.parse(locationUrl(city)));
  print("1");
    if(response.statusCode == 200) {
      print("1");
      final cities = jsonDecode(response.body) as List;
      print("1");
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('Error getting location id of : ${city}');
    }
  }
  //LocationId => Weather
  Future<Weather> fetchWeather(int locationId) async {
    final response = await httpClient.get(Uri.parse(weatherUrl(locationId)));
    if(response.statusCode != 200) {
      throw Exception('Error getting weather from locationId: ${locationId}');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }
  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }

  /*Future<List<String>> getCitiesNames(String city) async {

    final response = await httpClient.get(Uri.parse(locationUrl(city)));
    if(response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      print("repository");
      print(cities);
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('Error getting location id of : ${city}');
    }
  }*/
}