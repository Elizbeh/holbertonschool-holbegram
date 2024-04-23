import 'package:flutter/material.dart';
import 'package:holbegram/models/utils/posts.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holbegram',
        style: TextStyle(fontFamily: 'Billabong'),
        ),
        leading: Image.asset(
          'assets/logo.png',
          width: 30,
          height: 30,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.message_outlined),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: Posts(),
    );
  }
}