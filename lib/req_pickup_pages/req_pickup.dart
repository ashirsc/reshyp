import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weship/req_pickup_pages/confirmation.dart';

import 'from_address.dart';
import 'to_address.dart';
import 'size_and_weight.dart';
import 'pickup_time.dart';
import 'package:weship/domain.dart';
import 'package:geolocator/geolocator.dart';

class RequestPickupForm extends StatefulWidget {
  RequestPickupForm({Key key}) : super(key: key);

  @override
  _RequestPickupFormState createState() => _RequestPickupFormState();
}

class _RequestPickupFormState extends State<RequestPickupForm> {
  SendPackageRequest sendPackageRequest = new SendPackageRequest();
  updateReq(update) {
    // print('Updated req: $update');
    setState(() {
      sendPackageRequest = update;
    });
  }

  int formIndex = 0;
  List<Widget> formSegments;
  Future<Position> userCurrentPosition;

  @override
  void initState() {
    super.initState();
       userCurrentPosition = Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    formSegments = [
      FromAddress(
          sendPackageRequest: sendPackageRequest,
          updateSendPackagerequest: updateReq),
      ToAddress(
          sendPackageRequest: sendPackageRequest,
          updateSendPackagerequest: updateReq),
      SizeAndWeight(
          sendPackageRequest: sendPackageRequest,
          updateSendPackagerequest: updateReq),
      PickupTime(
          sendPackageRequest: sendPackageRequest,
          updateSendPackagerequest: updateReq),
      Confirmation(
          sendPackageRequest: sendPackageRequest,
          updateSendPackagerequest: updateReq)
    ];
  }

  void nextPage() {
    // print('req ${sendPackageRequest.toString()}');
    setState(() {
      formIndex = formIndex + 1;
    });
  }

  void lastPage() {
    // print('req ${sendPackageRequest.toString()}');
    setState(() {
      formIndex = formIndex - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Request Pickup'),
        ),
        body: SafeArea(
          child: FutureBuilder<Position>(
              future: userCurrentPosition,
              builder: (context, snapshot) {

                if (snapshot.hasError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Could not find your location"),
                  ));
                }
                if (snapshot.hasData) {
                sendPackageRequest.currentLocation =
                    new LatLng(snapshot.data.latitude, snapshot.data.longitude);
                print('user location: ${sendPackageRequest.currentLocation.toString()}');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: formSegments[formIndex],
                      ),
                      ButtonBar(
                        children: <Widget>[
                          (formIndex > 0)
                              ? RaisedButton(
                                  onPressed: lastPage,
                                  child: Text('Back'),
                                  color: Colors.grey,
                                )
                              : null,
                          (formIndex < formSegments.length - 1)
                              ? RaisedButton(
                                  onPressed: nextPage,
                                  child: Text('Next'),
                                  color: Colors.blue,
                                )
                              : null,
                        ],
                      )
                    ],
                  );
                }
                else {

                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
