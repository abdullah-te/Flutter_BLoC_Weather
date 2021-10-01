import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class SingleWeather extends StatelessWidget {
  final int index;
  //String bgImg='assets/images/cloudy.jpeg';
  SingleWeather(this.index);

  @override
  Widget build(BuildContext context) {
    BoxedIcon _mapWeatherConditionToIcon({required WeatherCondition weatherCondition,required Color color}) {
      switch(weatherCondition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          return BoxedIcon(WeatherIcons.day_sunny,size: 150,color:color);
          break;
        case WeatherCondition.hail:
        case WeatherCondition.snow:
        case WeatherCondition.sleet:
          return BoxedIcon(WeatherIcons.snow,size: 150,color:color);
          break;
        case WeatherCondition.heavyCloud:
          return BoxedIcon(WeatherIcons.cloud_up,size: 150,color:color);
          break;
        case WeatherCondition.heavyRain:
        case WeatherCondition.lightRain:
        case WeatherCondition.showers:
          return BoxedIcon(WeatherIcons.rain,color: color,size: 150 );
          break;
        case WeatherCondition.thunderstorm:
          return BoxedIcon(WeatherIcons.thunderstorm,size: 150,color:color);
          break;
        case WeatherCondition.unknown:
          return BoxedIcon(WeatherIcons.sunset,size: 150,color:color);
          break;
      }
      return BoxedIcon(WeatherIcons.sunset);
    }
    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.20,
                        ),
                        Text(
                          locationList[index].location,
                          style: GoogleFonts.lato(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            formatDate(locationList[index].lastUpdated,[
                              ' ',dd, '/', mm, '/', yyyy, '    ',
                              HH, ':', nn,' ',am]),
                           /*locationList[index].lastUpdated.toString(),*/
                            style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: _mapWeatherConditionToIcon(weatherCondition:
                          locationList[index].weatherCondition,color: Colors.white),
                        ),

                        Text(
                          locationList[index].temp.ceil().toString()+"°",
                          style: GoogleFonts.lato(
                            fontSize: 85,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            /*SvgPicture.asset(
                              locationList[index].iconUrl,
                              width: 34,
                              height: 34,
                              color: Colors.white,
                            ),*/
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              describeEnum(locationList[index].weatherCondition),
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Wind',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              locationList[index].wind.ceil().toString(),
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'km/h',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: 50,
                                  color: Colors.white38,
                                ),
                                Container(
                                  height: 5,
                                  width: locationList[index].wind/2,
                                  color: Colors.greenAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Humidity',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              locationList[index].humidity.ceil().toString(),
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Hyg',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: 50,
                                  color: Colors.white38,
                                ),
                                Container(
                                  height: 5,
                                  width: locationList[index].humidity/2,
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Air pressure',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              locationList[index].air.ceil().toString(),
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'kPa',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: 50,
                                  color: Colors.white38,
                                ),
                                Container(
                                  height: 5,
                                  width: locationList[index].air/50,
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}