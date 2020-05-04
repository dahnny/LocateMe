import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  Future<void> _takeImage() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          width: 100,
          height: 100,
          child: _image == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No image taken',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Expanded(
          child: FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: _takeImage,
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
          ),
        )
      ],
    );
  }
}
