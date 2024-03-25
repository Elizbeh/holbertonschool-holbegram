import 'package:flutter/material.dart';

Future main()  async {
  WidgetFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
