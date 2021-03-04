import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'service.dart';
import 'req_pickup_pages/req_pickup.dart';

class UserHome extends StatefulWidget {
  UserHome({Key key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        'Hi Drew',
        style: TextStyle(fontSize: 32),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RequestPickupForm()));
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text('Request item pickup'),
                // subtitle: Text('Small item pickup'),
              ),
              // ButtonBar(
              //   children: <Widget>[

              //     FlatButton(
              //       child: const Text('Delete'),
              //       onPressed: () {/* ... */},
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    ]);
  }

 
}
