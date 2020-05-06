import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function _onSelectImage;

  ImageInput(this._onSelectImage);

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

    if(imageFile == null){
      return;
    }

    setState(() {
      _image = imageFile;
    });

//    This gets the applicatoin directory in the internal storage
    final appDir  = await syspath.getApplicationDocumentsDirectory();
//    This gets the filename of the image
    final fileName = path.basename(imageFile.path);
//    This gets the path of the directory and then put the image in it
    final savedImage  = await imageFile.copy('${appDir.path}/$fileName');
    widget._onSelectImage(savedImage);
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
