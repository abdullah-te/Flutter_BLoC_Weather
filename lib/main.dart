// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/bloc/bloc/search_bloc.dart';
import 'package:weather_app/bloc/bloc/theme_bloc.dart';
import 'package:weather_app/bloc/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/states/theme_state.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/screens/weather_screen.dart';

void main() {
  //Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository = WeatherRepository(
      httpClient: http.Client()
  );
  //other blocs ?
  runApp(
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
        child:
          /*BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
          child: */MyApp(weatherRepository: weatherRepository,),

      )
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository}):
        assert(weatherRepository != null),super(key:key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
            title: 'Flutter Weather App with Bloc',
            theme: ThemeData(
              primaryColor: themeState.backgroundColor,
                //highlightColor: themeState.backgroundColor,
               // bottomAppBarColor: themeState.backgroundColor,
                secondaryHeaderColor: themeState.textColor,
              scaffoldBackgroundColor: themeState.backgroundColor,
            ),
            home: BlocProvider(
              create: (context) => WeatherBloc(
                  weatherRepository: weatherRepository),
              child: WeatherScreen(),
            )
        );
      },
    );
  }
}