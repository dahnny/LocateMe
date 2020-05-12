import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locate_me/helpers/db_helper.dart';
import 'package:locate_me/helpers/location_helper.dart';
import 'package:locate_me/models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
      String title, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: updatedLocation,
    );
//    add place to the list then notify the provider listeners
    _items.add(newPlace);
    notifyListeners();

    DbHelper.insert('user_places', {
//      This inserts into the database in the form of maps
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
//          This will create a new file with the path of the file
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address']),
          ),
        )
        .toList();
  }

  Place findPlaceById(String id){
//    check for the place that equals id
    return _items.firstWhere((item) => item.id ==  id);
  }

}
