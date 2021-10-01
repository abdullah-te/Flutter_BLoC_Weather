import 'package:equatable/equatable.dart';
enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

final List<Weather> locationList = [
 /* Weather(
    WeatherCondition.clear,
    "",
    36.1,
    38.1,
    40.1,
    12,
    "created1",
    DateTime.now(),
    "Damascus",
    *//*36.1,
    38.1,
    40.1,
    12,*//*
  ),
  Weather(
    WeatherCondition.snow,
    "formated2",
    36.0,
    38.2,
    40.0,
    12,
    "created2",
    DateTime.now(),
    "Rome",
   *//* 36.1,
    38.1,
    40.1,
    12,*//*
  ),*/
];
class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  late final String location;
  final double wind;
  final double air;
  final int humidity;
  final double visibility;
  //constructor
  Weather(
      this.weatherCondition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location,
      this.wind,
      this.air,
      this.humidity,
      this.visibility,
      );
  @override
  // TODO: implement props
  List<Object> get props => [
    weatherCondition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
    wind,
    air,
    humidity,
    visibility,
  ];

/*
consolidated_weather": [
    {
      "id": 5001437304061952,
      "weather_state_name": "Light Cloud",
      "weather_state_abbr": "lc",
      "wind_direction_compass": "SSE",
      "created": "2020-07-26T00:22:18.967978Z",
      "applicable_date": "2020-07-25",
      "min_temp": 22.825,
      "max_temp": 31.585,
      "the_temp": 32.2,
      "wind_speed": 4.388510937739601,
      "wind_direction": 165.1056162097894,
      "air_pressure": 1018.5,
      "humidity": 56,
      "visibility": 15.249070428696413,
      "predictability": 70
    },
    ...
 */
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
        _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']),
        consolidatedWeather['weather_state_name'] ?? '',
        consolidatedWeather['min_temp'] as double,
        consolidatedWeather['the_temp'] as double,
        consolidatedWeather['max_temp'] as double,
        jsonObject['woeid'] as int,
        consolidatedWeather['created'],
        DateTime.now(),
        jsonObject['title'],
      consolidatedWeather['wind_speed'] as double,
     consolidatedWeather['air_pressure'] as double,
      consolidatedWeather['humidity'] as int,
      consolidatedWeather['visibility'] as double,
    );
  }
  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }

}

