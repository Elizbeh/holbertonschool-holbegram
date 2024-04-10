
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'methods/auth_methods.dart';
//import 'screens/auth/upload_image_screen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthMethod authMethod = AuthMethod();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupUsernameController = TextEditingController();
  final TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController signupConfirmPasswordController = TextEditingController();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Holbegram',
      
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(
          emailController: loginEmailController,
          passwordController: loginPasswordController,
        ),
        '/signup': (context) => SignUpScreen(
          emailController: signupEmailController,
          usernameController: signupUsernameController,
          passwordController: signupPasswordController,
          passwordConfirmController: signupConfirmPasswordController,
        ),
      },
    );
  }
}

/*import 'package:flutter/material.dart';
import 'screens/auth/upload_image_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Holbegram',
      home: AddPicture(email: 'Lee@example.com', password: 'Leeexample', username: 'Lee',)
    );
  }
}*/
