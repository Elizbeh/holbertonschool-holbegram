import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../../methods/auth_methods.dart';

class SignUpScreen extends StatelessWidget {
  final authMethod = AuthMethod();
  
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  SignUpScreen({
    Key? key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 60,
            ),
            const Text('Sign up to see photos and videos from your friends'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                                          ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: passwordConfirmController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        BuildContext? localContext = context;
                        if (emailController.text.isEmpty || usernameController.text.isEmpty || passwordController.text.isEmpty || passwordConfirmController.text.isEmpty) {
                          ScaffoldMessenger.of(localContext).showSnackBar(
                            const SnackBar(content: Text('Please fill in all fields'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        if (passwordConfirmController.text != passwordConfirmController.text) {
                          ScaffoldMessenger.of(localContext).showSnackBar(
                            const SnackBar(content: Text('Passwords do not match'),
                            duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        //Call the signUpUser method from AuthMethod to register the user
                        String result = await authMethod.signUpUser(
                          email: emailController.text,
                          password: passwordController.text, 
                          username: usernameController.text,
                          );
                          if (result == 'success') {
                          // Navigate to the home screen 
                          } else {
                            // Show error message indicating sign-up failure
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(localContext).showSnackBar(
                              SnackBar(
                                content: Text(result),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }                         
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 24)),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        )),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 16), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

                 
