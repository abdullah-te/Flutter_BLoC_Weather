import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:weather_app/bloc/bloc/theme_bloc.dart';
import 'package:weather_app/bloc/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/events/theme_event.dart';
import 'package:weather_app/bloc/events/weather_event.dart';
import 'package:weather_app/bloc/states/theme_state.dart';
import 'package:weather_app/bloc/states/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/menu_screen.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/widgets/circular_indicator.dart';
import 'package:weather_app/widgets/builder_transformer.dart';
import 'package:weather_app/widgets/slider_dots.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherScreen> {
  late Completer<void> _completer;
  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }
  int _currentPage = 0;
  var  weather ;
  String bgImg='assets/images/cloudy.jpeg';

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              //Navigate to CitySearchScreen
              final typedCity = await Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => CitySearchScreen()
                ),
              );
              if(typedCity != null) {
                BlocProvider.of<WeatherBloc>(context).add(
                    WeatherEventNewRequested(city: typedCity)
                );
              }
            },
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.redAccent,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: GestureDetector(
                onTap: () => {
                  for(int i = 0; i < locationList.length; i++) {
                    BlocProvider.of<WeatherBloc>(context).add(
                        WeatherEventRequested(city:locationList[i].location))
                  }
                },
                child: Icon(
                  Icons.refresh,
                  size: 30,
                  color: Colors.redAccent,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: GestureDetector(
                onTap: () => {Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => MenuScreen()
                  ),
                )
                  /*for(int i = 0; i < locationList.length; i++) {
                  BlocProvider.of<WeatherBloc>(context).add(
                      WeatherEventRequested(city:locationList[i].location))
                }*/},
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  height: 30,
                  width: 30,
                  color: Colors.redAccent,
                ),
              ),
            ),

          ],
        ),
        body:  BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, weatherState) {
              if(weatherState is WeatherStateSuccess) {
                /* BlocProvider.of<ThemeBloc>(context).add(
                    ThemeEventWeatherChanged()
                );*/
                _completer.complete();
                _completer = Completer();
              }
            },
            builder: (context, weatherState) {
              if (weatherState is WeatherStateLoading) {
                return  Circularindicator(_currentPage);
              }
              if (weatherState is WeatherStateSuccess) {
                final weather = weatherState.weather;
                return BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, themeState) {
                      return Center(
                        child: RefreshIndicator(
                          onRefresh: () {
                            for(int i = 0; i < locationList.length; i++) {
                              BlocProvider.of<WeatherBloc>(context).add(
                                  WeatherEventRequested(city:locationList[i].location));
                            };
                            //return a "Completer object"
                            return _completer.future;
                          },
                          child: Center(
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(color: Colors.black38),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 140, left: 15),
                                    child: Row(
                                      children: [
                                        for(int i = 0; i < locationList.length; i++)
                                          if( i == _currentPage )
                                            SliderDot(true)
                                          else
                                            SliderDot(false)
                                      ],
                                    ),
                                  ),
                                  TransformerPageView(
                                    scrollDirection: Axis.horizontal,
                                    transformer: ScaleAndFadeTransformer(),
                                    viewportFraction: 0.8,
                                    onPageChanged: _onPageChanged,
                                    itemCount: locationList.length,
                                    itemBuilder: (ctx, i) => SingleWeather(i),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
              if(weatherState is WeatherStateFailure) {
                return Center(
                  child: const Text(
                    'Something went wrong',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  ),
                );
              }
              return const Center(
                child: Text(
                  'select a location first !',
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
        )

    );
  }
}