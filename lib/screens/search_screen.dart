import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/bloc/search_bloc.dart';
import 'package:weather_app/bloc/events/search_event.dart';
import 'package:weather_app/bloc/states/search_state.dart';
import 'package:weather_app/widgets/circular_indicator.dart';


class CitySearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CitySearchScreenState();
}
class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();
  late Completer<void> _completer;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SearchBloc(),
        child:BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {return Scaffold(
              //extendBodyBehindAppBar: true,
                appBar: AppBar(title: Text(''),
                  backgroundColor: Colors.transparent,
                  elevation: 2,),
                body:  Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              onChanged: (text) {
                                EasyDebounce.debounce(
                                    'my-debouncer',
                                    Duration(milliseconds: 1000),
                                        () => {BlocProvider.of<SearchBloc>(context).add(
                                        SearchEventRequest(city: text)
                                    )}
                                );
                              },
                              controller: _cityTextController,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme
                                          .of(context)
                                          .secondaryHeaderColor,)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme
                                        .of(context)
                                        .secondaryHeaderColor,)),

                                labelText: 'Enter a city',
                                hintText: 'Example: Chicago',
                                labelStyle: TextStyle(color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,),
                                hintStyle: TextStyle(color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,),
                              ),
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .secondaryHeaderColor,),
                            ),
                          ),
                        ),
                        /*IconButton(
                          icon: Icon(Icons.search, color: Theme
                              .of(context)
                              .secondaryHeaderColor,),
                          onPressed: () {
                            *//*if (!_cityTextController.text.isEmpty)
                            Navigator.pop(context, _cityTextController.text);*//*
                          },
                          color: Theme
                              .of(context)
                              .secondaryHeaderColor,

                        )*/
                      ],
                    ),
                    SizedBox(height: 30,),

                    BlocConsumer<SearchBloc,SearchState>(
                      listener: (context, searchState) {
                        if(searchState is SearchStateSuccess) {
                          _completer.complete();
                          _completer = Completer();
                        }
                      },
                      builder: (context,searchState)  {
                        if (searchState is SearchStateLoading) {
                          return  Center(child: Circularindicator(0));
                        }
                        else if(searchState is SearchStateSuccess){
                          return Expanded(
                              child: SingleChildScrollView(
                                  physics: ClampingScrollPhysics(),
                                //physics:  ScrollPhysics(),
                                  //scrollDirection: Axis.vertical,
                              child:Center(
                            child: Column(
                              children: <Widget>[
                                const Center(child: Text("Results"),),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchState.city.length,
                                  itemBuilder: (context,  index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(width: 0.7, color: Theme.of(context).secondaryHeaderColor),
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: const Icon(Icons.add,color: Colors.redAccent,),
                                        onTap: ()=>{Navigator.pop(context, searchState.city[index].name)},
                                        title: Text(searchState.city[index].name ,
                                            style: TextStyle(color:
                                            Theme.of(context).secondaryHeaderColor)),
                                        //tileColor:  Theme.of(context).secondaryHeaderColor==Colors.white ? Colors.blueGrey[200]: Colors.blue[50] ,

                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )));

                        }
                        else if(searchState is SearchStateInitial){
                          return
                            const Center(child: Text("SearchStateInitial"),);
                        }
                        else {
                          return const Center(child: Text("Something Went Wrong"),);
                        }
                      },
                    ),
                  ],
                )
            );
            }
        )
    );
  }
}