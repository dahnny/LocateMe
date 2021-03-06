import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locate_me/models/place.dart';
import 'package:locate_me/providers/user_places.dart';
import 'package:locate_me/widgets/image_input.dart';
import 'package:locate_me/widgets/place_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _placeLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }
//method to select place with latitude and longitude
  void _selectPlace(double lat, double lng){
    _placeLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _placeLocation == null) {
      return;
    }
    Provider.of<UserPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _placeLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Input'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          Expanded widget is the widget that gets as much space as it can get when used with a widget
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
//                    pass the reference to the function as a constructor
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    PlaceInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            color: Theme.of(context).accentColor,
            elevation: 0,
//            make the button sit at the bottom of the screen with no padding
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
