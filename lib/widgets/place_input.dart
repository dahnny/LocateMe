import 'package:flutter/material.dart';
import 'package:locate_me/helpers/location_helper.dart';
import 'package:locate_me/screens/map_screen.dart';
import 'package:location/location.dart';

class PlaceInput extends StatefulWidget {
  @override
  _PlaceInputState createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  String _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapUrl = LocationHelper.generatePreview(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if(selectedLocation ==  null){
      return;
    }
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
                onPressed: _getCurrentLocation),
            FlatButton.icon(
              onPressed: _selectOnMap,
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
