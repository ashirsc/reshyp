import 'package:flutter/material.dart';
import 'package:weship/service.dart';

import 'widgets.dart';
import 'package:weship/domain.dart';

class FromAddress extends StatefulWidget {
  const FromAddress(
      {Key key, this.sendPackageRequest, this.updateSendPackagerequest})
      : super(key: key);
  final SendPackageRequest sendPackageRequest;
  final Function updateSendPackagerequest;

  @override
  _FromAddressState createState() => _FromAddressState();
}

class _FromAddressState extends State<FromAddress> {
  String currentLocationPickupStr;
  Future<Map<dynamic, dynamic>> revGeocodeResponse;

  void setCurrentLocationPickup(val) {
    if (val == 'yes') {
      widget.sendPackageRequest.usingCurrentLocation = true;
      setState(() {
        currentLocationPickupStr = 'yes';
      });
    } else {
      widget.sendPackageRequest.usingCurrentLocation = false;
      setState(() {
        currentLocationPickupStr = 'no';
      });
    }
  }

  void setFromAddress(Address address) {
    print('in set from address');
    widget.sendPackageRequest.fromAddress = address;
    print('setting request to ${widget.sendPackageRequest.toString()}');
    widget.updateSendPackagerequest(widget.sendPackageRequest);
  }

  @override
  void initState() {
    super.initState();
    revGeocodeResponse = getPossibleUserAddresses(
        widget.sendPackageRequest.currentLocation.latitude,
        widget.sendPackageRequest.currentLocation.longitude);
    if (widget.sendPackageRequest.usingCurrentLocation) {
      currentLocationPickupStr = 'yes';
    } else {
      currentLocationPickupStr = 'no';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                'Would you like your package to be picked up from your current location.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Radio(
                  value: 'yes',
                  groupValue: currentLocationPickupStr,
                  onChanged: setCurrentLocationPickup,
                ),
                new Text(
                  'Yes',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 'no',
                  groupValue: currentLocationPickupStr,
                  onChanged: setCurrentLocationPickup,
                ),
                new Text(
                  'No',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            (widget.sendPackageRequest.usingCurrentLocation)
                ? FutureBuilder(
                    future: revGeocodeResponse,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container();
                      } else if (snapshot.hasData) {
                        List<dynamic> results = snapshot.data['results'];
                        print('rev geocode results: $results');
                        return possilbeAddressList(results);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : AddressFragment(
                    setAddress: setFromAddress,
                    header: 'Where would you like this to be picked up?',
                    initial: widget.sendPackageRequest.fromAddress,
                  ),
          ],
        ),
      ),
    );
  }

  Widget possilbeAddressList(List<dynamic> results) {
    List<Widget> possibleAddresses = new List.of([
      Text(
        "Please select your current address:",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      )
    ]);
    results.forEach((address) {
      print(address['geometry']['location_type']);
      if (address['geometry']['location_type'] == 'ROOFTOP')
        possibleAddresses.add(FlatButton(
          onPressed: () {
            Address newFromAddress = Address.parseFromAddressComponents(address['address_components']);
            widget.sendPackageRequest.fromAddress = newFromAddress;
            print(widget.sendPackageRequest.fromAddress.toString());
          },
          child: Text(address['formatted_address'], style: TextStyle(color: Colors.blue),)));
    });
    return Column(
      children: possibleAddresses,
    );
  }
}
