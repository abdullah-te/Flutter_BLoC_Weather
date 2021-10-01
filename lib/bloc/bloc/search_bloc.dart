import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/events/search_event.dart';
import 'package:weather_app/bloc/states/search_state.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/repositories/city_repository.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  /*final CityRepository searchRepository;

  SearchBloc({required this.searchRepository})
      :
        assert(searchRepository != null),
        super(SearchStateInitial());*/

  SearchBloc():super(SearchStateInitial());
  @override
  Stream<SearchState> mapEventToState(SearchEvent searchEvent) async* {
    if (searchEvent is SearchEventRequest) {
      yield SearchStateLoading();
      try {
        print("b1");
        final List<City> city = await CityRepository.getCitySuggestions(searchEvent.city);
       // print(city[0].name);
        print("b2");
        yield SearchStateSuccess(city: city);
      }  catch (exception) {
        yield SearchStateFailure();
      }
    }else if(searchEvent is SearchEventWait){
        try {
          print("Wait");

          // yield SearchStateSuccess(city: city);
        }  catch (exception) {
          yield SearchStateFailure();
        }

    }
  }
}