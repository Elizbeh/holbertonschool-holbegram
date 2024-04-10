import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  AddPicture({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  _AddPictureState createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = Uint8List.fromList(await pickedFile.readAsBytes());
      });
    }
  }

  void selectImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = Uint8List.fromList(await pickedFile.readAsBytes());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload User Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.memory(
                    _image!,
                    width: 200,
                    height: 200,
                  )
                : Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectImageFromGallery,
              child: Text('Select Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectImageFromCamera,
              child: Text('Take Picture'),
            ),
          ],
        ),
      ),
    );
  }
}
