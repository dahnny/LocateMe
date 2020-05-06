import 'dart:io';

import 'package:flutter/material.dart';
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
  }
}
