import 'package:flutter/material.dart';

import 'widgets.dart';
import 'package:weship/domain.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PickupTime extends StatefulWidget {
  const PickupTime({Key key, this.sendPackageRequest, this.updateSendPackagerequest})
      : super(key: key);

  final SendPackageRequest sendPackageRequest;
  final Function updateSendPackagerequest;

  @override
  _PickupTimeState createState() => _PickupTimeState();
}

class _PickupTimeState extends State<PickupTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(2020, 6, 5), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
                  // SendPackageRequest sendPackageRequest = new SendPackageRequest();
                widget.sendPackageRequest.time = date;
                widget.updateSendPackagerequest(widget.sendPackageRequest);

              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Text(
              'Choose pick up time',
              style: TextStyle(color: Colors.blue),
            )),
      ],
    ));
  }
}
