import 'package:flutter/material.dart';
import 'package:locate_me/models/place.dart';

class UserPlaces with ChangeNotifier{

  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

}