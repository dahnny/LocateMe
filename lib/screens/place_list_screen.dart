import 'package:flutter/material.dart';
import 'package:locate_me/providers/user_places.dart';

import 'add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
//        This future waits for this to load before performing a required action
        future: Provider.of<UserPlaces>(context).fetchAndSetPlaces(),
//        checks if it is still loading and displays a spinner
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<UserPlaces>(
                child: Center(child: Text('There are no places, you can add some')),
                builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(userPlaces.items[index].image),
                          ),
                          title: Text(userPlaces.items[index].title),
                          onTap: () {},
                        ),
                        itemCount: userPlaces.items.length,
                      ),
              ),
      ),
    );
  }
}
