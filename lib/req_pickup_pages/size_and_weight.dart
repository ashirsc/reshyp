import 'package:flutter/material.dart';

import 'package:weship/domain.dart';

class SizeAndWeight extends StatefulWidget {
  const SizeAndWeight(
      {Key key, this.sendPackageRequest, this.updateSendPackagerequest})
      : super(key: key);
  final SendPackageRequest sendPackageRequest;
  final Function updateSendPackagerequest;
  @override
  _SizeAndWeightState createState() => _SizeAndWeightState();
}

class _SizeAndWeightState extends State<SizeAndWeight> {
  void setSize({int height, int width, int depth, String unit}) {
    PackageSize size =
        new PackageSize.fromAnother(widget.sendPackageRequest.size);

    if (height != null) {
      size.height = height;
    }
    if (width != null) {
      size.width = width;
    }
    if (depth != null) {
      size.depth = depth;
    }
    size.unit = sizeUnit;

    SendPackageRequest newReq = widget.sendPackageRequest;
    newReq.size = size;

    widget.updateSendPackagerequest(newReq);
  }

  void setWeight({int amount, String unit}) {
    PackageWeight weight =
        new PackageWeight.fromAnother(widget.sendPackageRequest.weight);

    if (amount != null) {
      weight.amount = amount;
    }
    weight.unit = weightUnit;

    SendPackageRequest newReq = widget.sendPackageRequest;
    newReq.weight = weight;
    widget.updateSendPackagerequest(newReq);
  }

  var sizeRadioValue;
  var setSizeRadioValue;

  String sizeUnit = 'inch';
  String weightUnit = 'ounce';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('What are the rough dimensions of your package?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setSize(height: int.parse(val));
                  },
                  decoration: InputDecoration(
                    labelText: 'Height',
                  ),
                ),
              ),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setSize(width: int.parse(val));
                  },
                  decoration: InputDecoration(
                    labelText: 'Width',
                  ),
                ),
              ),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setSize(depth: int.parse(val));
                  },
                  decoration: InputDecoration(
                    labelText: 'Depth',
                  ),
                ),
              ),
              Flexible(
                  child: DropdownButton<String>(
                value: sizeUnit,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String val) {
                  setState(() {
                    sizeUnit = val;
                  });
                  setSize();
                },
                items: <String>['inch', 'foot']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            ],
          ),
          Text('About how much does you package weigh?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setWeight(amount: int.parse(val));
                  },
                  decoration: InputDecoration(
                    labelText: 'Weight',
                  ),
                ),
              ),
              Flexible(
                  child: DropdownButton<String>(
                value: weightUnit,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String val) {
                  setState(() {
                    weightUnit = val;
                  });
                  setWeight();
                },
                items: <String>['ounce', 'pound']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
