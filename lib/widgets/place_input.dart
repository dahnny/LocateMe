import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PlaceInput extends StatefulWidget {
  @override
  _PlaceInputState createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  String _previewImageUrl;

  Future<void> _getCurrentLocation() async{
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'No Location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Users location'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
