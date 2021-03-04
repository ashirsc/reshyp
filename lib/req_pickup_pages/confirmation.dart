import 'package:flutter/material.dart';

import 'widgets.dart';
import 'package:weship/domain.dart';
import '../service.dart';

class Confirmation extends StatefulWidget {
  const Confirmation(
      {Key key, this.sendPackageRequest, this.updateSendPackagerequest})
      : super(key: key);
  final SendPackageRequest sendPackageRequest;
  final Function updateSendPackagerequest;
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  Future<List<dynamic>> estimates;
  bool loading = false;
  String shippingType = 'ground';
  void setShippingType(type) {
    setState(() {
      shippingType = type;
    });
  }

  @override
  void initState() {
    super.initState();
    estimates = getPriceEstimate(widget.sendPackageRequest);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: estimates,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('snapshot: ${snapshot.data[3]}');
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: 'ground',
                    groupValue: shippingType,
                    onChanged: setShippingType,
                  ),
                  Text(
                      'Ground \$${snapshot.data[3]['shipping_amount']['amount']}'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'overnight',
                    groupValue: shippingType,
                    onChanged: setShippingType,
                  ),
                  Text(
                      'Overnight \$${snapshot.data[1]['shipping_amount']['amount']}'),
                ],
              ),
              Center(
                child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      print('requesting pickup');
                      setState(() {
                        loading = true;
                      });
                      try {
                        await requestPickup(widget.sendPackageRequest);
                      } catch (e) {} finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: requestPickupButton()),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget requestPickupButton() {
    Widget buttonText = Text(
      'Request Pickup',
      style: TextStyle(color: Colors.white),
    );
    if (loading) {
      return Row(
        children: <Widget>[buttonText, CircularProgressIndicator()],
      );
    } else {
      return buttonText;
    }
  }
}
