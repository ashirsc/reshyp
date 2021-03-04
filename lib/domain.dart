
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SendPackageRequest {
  SendPackageRequest.fromRequest(SendPackageRequest currentRequest) {
    time = currentRequest.time;
    toAddress = currentRequest.toAddress;
    fromAddress = currentRequest.fromAddress;
    size = currentRequest.size;
    weight = currentRequest.weight;
    usingCurrentLocation = currentRequest.usingCurrentLocation;
    currentLocation = currentRequest.currentLocation;
  }

  SendPackageRequest() {
    time = DateTime.now();
    toAddress = new Address();
    fromAddress = new Address();
    size = new PackageSize();
    weight = new PackageWeight();
    usingCurrentLocation = true;
    currentLocation = new LatLng(42, -111);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = new Map();
    m['username'] = 'testuser';
    m['pickupFrom'] = fromAddress.toJson();
    m['sendTo'] = toAddress.toJson();
    m['pickupTime'] = time.toIso8601String();
    m['size'] = size.toJson();
    m['weight'] = weight.toJson();
    return m;
  }

  bool usingCurrentLocation;
  Address toAddress;
  Address fromAddress;
  PackageSize size;
  PackageWeight weight;
  DateTime time;
  LatLng currentLocation;

  String toString() {
    return 'to: ${toAddress.toString()}\nfrom: ${fromAddress.toString()}\n size: ${size.toString()}\nweight: ${weight.toString()}\ntime: ${time.toIso8601String()}';
  }
}

class PackageSize {
  PackageSize() {
    height = 0;
    width = 0;
    depth = 0;
    unit = 'inch';
  }
  PackageSize.fromAnother(PackageSize another) {
    height = another.height;
    width = another.width;
    depth = another.depth;
    unit = another.unit;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = new Map();
    m['height'] = height;
    m['width'] = width;
    m['depth'] = depth;
    m['unit'] = unit;
    return m;
  }

  int height;
  int width;
  int depth;
  String unit;
}

class PackageWeight {
  PackageWeight() {
    amount = 0;

    unit = 'ounce';
  }
  PackageWeight.fromAnother(PackageWeight another) {
    amount = another.amount;
    unit = another.unit;
  }
  int amount;
  String unit;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = new Map();
    m['amount'] = amount;
    m['unit'] = unit;
    
    return m;
  }
}

class Address {
  Address() {
    attention = '';
    street1 = '';
    street2 = '';
    city = '';
    state = '';
    zip = '';
  }

  Address.parseFromAddressComponents(List<dynamic> comps) {
    attention = '';
    street2 = '';
    String street_number = comps.where((comp) {
      List types = comp['types'];
      return types.contains('street_number');
    }).toList()[0]['long_name'];
    String route = comps.where((comp) {
      List types = comp['types'];
      return types.contains('route');
    }).toList()[0]['long_name'];
    street1 = '$street_number $route';

     city = comps.where((comp) {
      List types = comp['types'];
      return types.contains('locality');
    }).toList()[0]['long_name'];
     state = comps.where((comp) {
      List types = comp['types'];
      return types.contains('administrative_area_level_1');
    }).toList()[0]['long_name'];
     zip = comps.where((comp) {
      List types = comp['types'];
      return types.contains('postal_code');
    }).toList()[0]['long_name'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = new Map();
    m['attention'] = attention;
    m['street1'] = street1;
    m['street2'] = street2;
    m['city'] = city;
    m['state'] = state;
    m['zip'] = zip;
    return m;
  }

  String attention = '';
  String street1 = '';
  String street2 = '';
  String city = '';
  String state = '';
  String zip = '';

  String toString() {
    return '$attention\n $street1 $street2\n $city, $state $zip\n';
  }
}
