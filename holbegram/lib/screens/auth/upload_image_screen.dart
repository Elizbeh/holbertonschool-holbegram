import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '/methods/auth_methods.dart';
import 'package:cross_file_image/cross_file_image.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    Key? key,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  XFile? _image;
  final AuthMethod _authMethod = AuthMethod();

  void selectImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void selectImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    try {
      String result = await _authMethod.signUpUser(
        email: widget.email,
        password: widget.password,
        username: widget.username,
        file: _image != null ? await _image!.readAsBytes() : null,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error signing up user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing up user. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 28),
            Text(
              'Holbegram',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 50),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Hello ${widget.username} Welcome to Holbegram',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'Choose an image from gallery or take a new one',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  _image == null
                      ? Image.asset(
                          'assets/images/Sample_User_Icon.png',
                          height: 250,
                          width: 250,
                        )
                      : Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: XFileImage(_image!),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.photo_size_select_large_outlined),
                        onPressed: () => selectImageFromGallery(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.photo_size_select_large_outlined),
                        onPressed: () => selectImageFromCamera(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: signUpUser,
                      child: const Text(
                        'next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
