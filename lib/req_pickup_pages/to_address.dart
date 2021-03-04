import 'package:flutter/material.dart';

import 'widgets.dart';
import 'package:weship/domain.dart';


class ToAddress extends StatefulWidget {
  ToAddress({Key key, this.sendPackageRequest, this.updateSendPackagerequest})
      : super(key: key);
  SendPackageRequest sendPackageRequest;
  Function updateSendPackagerequest;

  @override
  _ToAddressState createState() => _ToAddressState();
}


class _ToAddressState extends State<ToAddress> {

  void setToAddress(Address address) {
    widget.sendPackageRequest.toAddress = address;
    print('setting request to ${widget.sendPackageRequest.toString()}');
    widget.updateSendPackagerequest(widget.sendPackageRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Where are you sending this to?'),
          AddressFragment(initial: widget.sendPackageRequest.toAddress, setAddress: setToAddress),
        ],
      ),
    );
  }
}