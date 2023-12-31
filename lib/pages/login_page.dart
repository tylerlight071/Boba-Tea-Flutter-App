// ignore_for_file: use_build_context_synchronously

import 'package:boba_tea_app/components/login_button.dart';
import 'package:boba_tea_app/components/login_fields.dart';
import 'package:boba_tea_app/components/square_tile.dart';
import 'package:boba_tea_app/pages/forgot_password_page.dart';
import 'package:boba_tea_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({required this.onTap, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in and navigate to home page
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible: false,
    );

    // sign user in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Dismiss the dialog when sign-in is successful
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        // Dismiss the dialog when an error occurs
        Navigator.of(context).pop();
        if (e is FirebaseAuthException) {
          String message;
          if (e.code == 'invalid-credential') {
            message = 'Incorrect Email or Password.';
          } else if (e.code == 'user-disabled') {
            message = 'This account has been disabled.';
          } else if (e.code == 'user-not-found') {
            message = 'This account does not exist.';
          } else if (e.code == 'wrong-password') {
            message = 'Incorrect Email or Password.';
          } else {
            message = 'An error occurred while signing in.';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          rethrow;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0A599),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              //logo
              const Icon(
                Icons.lock,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(
                height: 50,
              ),

              //welcome back, you've been missed!
              const Text("Welcome back, you've been missed!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 25,
              ),

              // username textfield
              LoginFields(
                hintText: "Email",
                controller: emailController,
                obscureText: false,
              ),

              // password textfield
              LoginFields(
                hintText: "Password",
                controller: passwordController,
                obscureText: true,
              ),

              // forgot password button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ForgotPasswordPage();
                    }));
                  },
                  child: const Text("Forgot Password?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // login button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoginButton(
                  text: "Sign In",
                  signUserIn: () => signUserIn(),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Or continue with",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.white,
                    ))
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              SquareTile(
                  onTap: () => AuthService().signInWithGoogle(),
                  imagePath: 'lib/assets/images/google_logo.png'),
              
              const SizedBox(
                width: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                // not a member? sign up here
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Register now",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF685B54),
                        )),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
