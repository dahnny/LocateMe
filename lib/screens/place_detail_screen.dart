
import 'package:flutter/material.dart';
import 'package:locate_me/providers/user_places.dart';
import 'package:locate_me/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place_screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<UserPlaces>(context).findPlaceById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text("View On Map"),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
