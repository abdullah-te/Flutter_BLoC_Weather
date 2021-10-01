import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widgets/slider_dots.dart';

class Circularindicator extends StatelessWidget {
  int _currentPage;
  Circularindicator(this._currentPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(

        children: [
          Container(
            decoration: BoxDecoration(color: Colors.black38),
          ),
          Container(
            margin: EdgeInsets.only(top: 140, left: 15),
            child: Row(
              children: [
                for(int i = 0; i < locationList.length; i++)
                  if( i == _currentPage )
                    SliderDot(true)
                  else
                    SliderDot(false)
              ],
            ),
          ),
          Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor,))
        ],
      ),
    );
  }
}