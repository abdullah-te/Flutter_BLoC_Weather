import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/bloc/theme_bloc.dart';
import 'package:weather_app/bloc/events/theme_event.dart';
import 'package:weather_app/bloc/states/theme_state.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 2,),
      body: ListView(
        children: <Widget>[
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return Container(
               //color: themeState.backgroundColor,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Mode' ,style: TextStyle(color: themeState.textColor),),
                      isThreeLine: false,
                      subtitle: Text(
                          themeState.textColor == Colors.white ?
                          'Dark' : 'Light'
                      ,style: TextStyle(color: themeState.textColor),),
                      trailing: Switch(
                          value: themeState.textColor == Colors.white,
                          onChanged: (_) => BlocProvider.of<ThemeBloc>(context).
                          add(ThemeEventWeatherChanged())

                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}