import 'package:flutter/material.dart';
import 'package:weship/domain.dart';

class AddressFragment extends StatefulWidget {
  const AddressFragment({Key key, this.setAddress, this.header, this.initial}) : super(key: key);
  final Function setAddress;
  final String header;
  final Address initial;

  @override
  _AddressFragmentState createState() => _AddressFragmentState();
}

class _AddressFragmentState extends State<AddressFragment> {
  Address _address = new Address();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (widget.header == null) ? Container() : Text(widget.header),
        TextFormField(
          initialValue: widget.initial.street1,
          onChanged: (val) {
            _address.street1 = val;
            widget.setAddress(_address);
          },
          decoration: InputDecoration(
              labelText: 'Street 1',
              // border: InputBorder.none,
              hintText: '100 E 100 N'),
        ),
        TextFormField(
                    initialValue: widget.initial.street2,
          onChanged: (val) {
            _address.street2 = val;
            widget.setAddress(_address);
          },
          decoration: InputDecoration(
              labelText: 'Street 2',
              // border: ,
              hintText: 'Suite 4'),
        ),
        TextFormField(
                    initialValue: widget.initial.city,

          onChanged: (val) {
            _address.city = val;
            widget.setAddress(_address);
          },
          decoration: InputDecoration(
              labelText: 'City',
              // border: InputBorder.none,
              hintText: 'Enter a search term'),
        ),
        Row(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                            initialValue: widget.initial.state,

                  onChanged: (val) {
                    _address.state = val;
                    widget.setAddress(_address);
                  },
                  decoration: InputDecoration(
                      labelText: 'State',
                      // border: InputBorder.none,
                      hintText: 'UT'),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                            initialValue: widget.initial.zip,

                  onChanged: (val) {
                    _address.zip = val;
                    widget.setAddress(_address);
                  },
                  decoration: InputDecoration(
                      labelText: 'Zip',
                      // border: InputBorder.none,
                      hintText: '84000'),
                ),
              ),
            ),
          ],
        ),
      ],
      // ),
    );
  }
}
