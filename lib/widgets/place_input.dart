import 'package:flutter/material.dart';
import 'package:locate_me/helpers/location_helper.dart';
import 'package:locate_me/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceInput extends StatefulWidget {
  final Function onSelectPlace;

  PlaceInput(this.onSelectPlace);

  @override
  _PlaceInputState createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  String _previewImageUrl;

  void _staticUrl(double lat, double lng) {
//    this generates the image preview
    final staticMapUrl = LocationHelper.generatePreview(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
//    get the user present location
      final locData = await Location().getLocation();
      _staticUrl(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
//    This collects the location from the screen that pops
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) =>
            MapScreen(
              isSelecting: true,
            ),
      ),
    );
//    checks if it does not return anything
    if (selectedLocation == null) {
      return;
    }
    _staticUrl(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
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
                textColor: Theme
                    .of(context)
                    .primaryColor,
                onPressed: _getCurrentLocation),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Users location'),
              textColor: Theme
                  .of(context)
                  .primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
