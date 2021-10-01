import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/events/theme_event.dart';
import 'package:weather_app/bloc/states/theme_state.dart';
import 'package:weather_app/models/weather_model.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  //initial state
  ThemeBloc():
        super(ThemeState(
          backgroundColor: Colors.white,
          textColor: Colors.black
      ));
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    ThemeState newThemeState;
    if(themeEvent is ThemeEventWeatherChanged) {

      final newThemeState = ThemeState(
          backgroundColor: state.backgroundColor == Colors.white ?
          Colors.black : Colors.white, textColor: state.textColor==Colors.black?
        Colors.white:Colors.black
      );

      yield newThemeState;
    }
  }
}


