import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weship/service.dart';

Widget getDriverWidget() {
  return StreamBuilder(
      stream: Firestore.instance.collection('pickups').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Text('loading...');
        else
          return ListView.builder(
              itemExtent: 160,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buildPickupItem(
                    context, snapshot.data.documents[index]);
              });
      });
}

Widget _buildPickupItem(BuildContext context, pickup) {
  
  // print('pickup: ${pickup}');

  var location = pickup['where'];
  return Center(
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('John'),
            subtitle: Text('Small item pickup'),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('View on map'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PickupMap(
                              target:
                                  LatLng(location.latitude, location.longitude),
                            )),
                  );
                },
              ),
              FlatButton(
                child: const Text('Delete'),
                onPressed: () {
                  deletePickup(pickup.documentID);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class PickupMap extends StatefulWidget {
  PickupMap({Key key, this.target}) : super(key: key);
  final LatLng target;
  @override
  State<PickupMap> createState() => PickupMapState();
}

class PickupMapState extends State<PickupMap> {
  Completer<GoogleMapController> _controller = Completer();
  var zoom = 15.5;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Sample"),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        markers: Set<Marker>.from(
            [Marker(markerId: MarkerId('hello'), position: widget.target)]),
        initialCameraPosition:
            new CameraPosition(target: widget.target, zoom: zoom),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('go'),
      ),
    );
  }
}
