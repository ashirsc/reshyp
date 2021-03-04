import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'domain.dart';

const String GOOGLE_MAPS_API_KEY = 'AIzaSyCKPNiLtRY-Qh-ZOvHgOYlbXGERk7osXg4';

Future<void> requestPickup(SendPackageRequest request) async {
  var fs = Firestore.instance.collection('pickups');

  
  try {
    await fs.add(request.toJson());
    print('added ${request.toJson()}');
  } catch (e) {
    print('failed to request pickup');
    print(e);
  }
  return;
}

Future<List<dynamic>> getPriceEstimate(SendPackageRequest req) async {
  Map<String, String> headers = {
    'API-Key': 'TEST_8M61YB54X5ITmfEaDrMBDVAYDF4dQeRRCBbnCLNshyk',
    'Content-Type': 'application/json'
  };

  String body = jsonEncode({
    "carrier_ids": [
      "se-237513", //ups
      "se-237514" //fedex
    ],
    "from_country_code": "US",
    "from_postal_code": req.fromAddress.zip,
    "to_country_code": "US",
    "to_postal_code": req.toAddress.zip,
    "to_city_locality": req.toAddress.city,
    "to_state_province": req.toAddress.state,
    "weight": {"value": req.weight.amount, "unit": req.weight.unit},
    "dimensions": {
      "unit": req.size.unit,
      "length": req.size.depth,
      "width": req.size.width,
      "height": req.size.height
    },
    "confirmation": "none",
    "address_residential_indicator": "no"
  });

  print('gettign price estimate');
  print('sending${body.toString()}');
  var pricingEstimateRes = await http.post(
      'https://api.shipengine.com/v1/rates/estimate',
      headers: headers,
      body: body.toString());
  var decodedRes = jsonDecode(pricingEstimateRes.body);
  var estimates = List.from(decodedRes);
  estimates.forEach((e) =>
      {print('estimates: ${e['shipping_amount']}::${e['service_code']}')});
  return estimates;
}

Future<Map<dynamic, dynamic>> getPossibleUserAddresses(
    double lat, double lng) async {
  String revGeocodeEndpoint =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_MAPS_API_KEY';
  print('calling $revGeocodeEndpoint');
  var revGeocodeRawRes = await http.get(revGeocodeEndpoint);
  dynamic decodedRes = jsonDecode(revGeocodeRawRes.body);
  print(decodedRes);
  return decodedRes;
}

Future<void> deletePickup(String id) async {
    var fs_pickups = Firestore.instance.collection('pickups');

    fs_pickups.document(id).delete();

}