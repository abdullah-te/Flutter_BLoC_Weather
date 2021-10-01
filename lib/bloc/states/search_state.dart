import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/weather_model.dart';


abstract class SearchState extends Equatable {
  const SearchState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class SearchStateInitial extends SearchState {}
class SearchStateLoading extends SearchState {}
class SearchStateFailure extends SearchState {}

class SearchStateSuccess extends SearchState {
  final List<City> city;
  const SearchStateSuccess({required this.city}):
        assert(city != null);
  @override
  // TODO: implement props
  List<Object> get props => [city];
}
class SearchStateWait extends SearchState {
  final String city;
  const SearchStateWait({required this.city}):
        assert(city != null);
  @override
  // TODO: implement props
  List<Object> get props => [city];
}