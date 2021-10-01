import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/utils/const/const.dart';


class CityRepository {

  static Future<List<City>> getCitySuggestions(String query) async {
    final url = Uri.parse(locationUrl(query));
    print('1');
    final response = await http.get(url);
    print('2');
    if (response.statusCode == 200) {
      print('3');
      final List cities = json.decode(response.body);
      //print(cities);
      return cities.map((json) => City.fromJson(json)).where((city) {
        final nameLower = city.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}