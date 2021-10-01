import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/weather_model.dart';



abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}
class ThemeEventWeatherChanged extends ThemeEvent {

  const ThemeEventWeatherChanged();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


