import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchEventRequest extends SearchEvent {
  final String city;
  const SearchEventRequest({required this.city})
      : assert(city != null);
  @override
  List<Object> get props => [city];
}

class SearchEventWait extends SearchEvent {
  final String city;
  const SearchEventWait({required this.city})
      : assert(city != null);
  @override
  List<Object> get props => [city];
}