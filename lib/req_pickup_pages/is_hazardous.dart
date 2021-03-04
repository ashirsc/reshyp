import 'package:flutter/material.dart';

import 'widgets.dart';



class IsHazardous extends StatelessWidget {
   IsHazardous({Key key}) : super(key: key);

  var hazardousRadioVal;
  var setHazardousRadioValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text('Does your package contain hazardous materials?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: hazardousRadioVal,
                    onChanged: setHazardousRadioValue,
                  ),
                  new Text(
                    'no',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: hazardousRadioVal,
                    onChanged: setHazardousRadioValue,
                  ),
                  new Text(
                    'yes',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
      ],)
    );
  }
}