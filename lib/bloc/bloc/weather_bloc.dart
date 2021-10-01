import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/events/weather_event.dart';
import 'package:weather_app/bloc/states/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}):
        assert(weatherRepository != null),
        super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async*{
    if(weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        print("1");
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        for(int i=0;i<locationList.length;i++){
          if(locationList[i].location==weather.location){
            //locationList[i].location="asd";
            locationList[locationList.indexWhere(
                    (element) => element.location == weather.location)]=weather;
            print(locationList[i].location);
          }
          print(locationList[i].location);
        }
        print("3");
        yield WeatherStateSuccess(weather: weather);
      }catch(exception) {
        yield WeatherStateFailure();
      }
    } if(weatherEvent is WeatherEventNewRequested) {
      yield WeatherStateLoading();
      try {
        print("new");
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        for(int i=0;i<locationList.length;i++){
          if(locationList[i].location==weather.location) {
            yield WeatherStateSuccess(weather: weather);
            return ;
            }
          }
        locationList.add(weather);
        yield WeatherStateSuccess(weather: weather);
      }catch(exception) {
        yield WeatherStateFailure();
      }
    }else if(weatherEvent is WeatherEventRefresh) {
      try {
        print("1");
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        print("2");
        for(int i=0;i<locationList.length;i++){
          if(locationList[i].location==weather.location){
            //locationList[i].location="asd";
            locationList[locationList.indexWhere(
                    (element) => element.location == weather.location)]=weather;
            print(locationList[i].location);
          }
          print(locationList[i].location);
        }
        print("3");
        yield WeatherStateSuccess(weather: weather);
      }catch(exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/events/weather_event.dart';
import 'package:weather_app/bloc/states/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}):
        assert(weatherRepository != null),
        super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async*{
    if(weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        print("1");
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        for(int i=0;i<locationList.length;i++){
          if(locationList[i].location==weather.location){
            //locationList[i].location="asd";
            locationList[locationList.indexWhere(
                    (element) => element.location == weather.location)]=weather;
            print(locationList[i].location);
          }
          print(locationList[i].location);
        }
        print("3");
        yield WeatherStateSuccess(weather: weather);
      }catch(exception) {
        yield WeatherStateFailure();
      }
    } if(weatherEvent is WeatherEventNewRequested) {
      yield WeatherStateLoading();
      try {
        print("new");
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        print("new");
        locationList.add(weather);
        print("new");
        yield WeatherStateSuccess(weather: weather);
      }catch(exception) {
        yield WeatherStateFailure();
      }
    }else if(weatherEvent is WeatherEventRefresh) {
      try {
        print("1");
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        print("2");
        for(int i=0;i<locationList.length;i++){
          if(locationList[i].location==weather.location){
            //locationList[i].location="asd";
            locationList[locationList.indexWhere(
                    (element) => element.location == weather.location)]=weather;
            print(locationList[i].location);
          }
          print(locationList[i].location);
        }
        print("3");
        yield WeatherStateSuccess(weather: weather);
      }catch(exception) {
        yield WeatherStateFailure();
      }
    }
  }
}*/
