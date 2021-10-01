import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  //constructor
  City(
      this.name,
      );
  @override
  // TODO: implement props
  List<Object> get props => [
    name
  ];

  factory City.fromJson(dynamic jsonObject) {
    return City(
        jsonObject['title']
    );
  }

}

