import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locate_me/helpers/db_helper.dart';
import 'package:locate_me/models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: null,
    );
//    add place to the list then notify the provider listeners
    _items.add(newPlace);
    notifyListeners();

    DbHelper.insert('user_places', {
//      This inserts into the database in the form of maps
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('user_places');
    _items = dataList.map(
      (item) => Place(
          id: item['id'],
          title: item['title'],
//          This will create a new file with the path of the file
          image: File(item['image']),
          location: null),
    ).toList();
  }
}
