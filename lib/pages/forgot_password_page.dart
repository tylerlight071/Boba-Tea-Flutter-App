// ignore_for_file: use_build_context_synchronously

import 'package:boba_tea_app/components/login_button.dart';
import 'package:boba_tea_app/components/login_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Check your inbox.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found with this email.';
        } else {
          message = 'An error occurred while sending the password reset email.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // If the exception is not a FirebaseAuthException, rethrow it.
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // go back to login page
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const Positioned(
              top: 80, // Adjust this value to move the email icon up or down
              left: 0,
              right: 0,
              child: Icon(Icons.email, size: 160, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 285), // Add some space at the top of the Column
              child: Column(
                children: [
                  const Text('Enter your email to reset your password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  LoginFields(
                    hintText: "Email",
                    obscureText: false,
                    controller: _emailController,
                  ),
                  // using LoginButton to match the style of the other buttons
                  LoginButton(
                      signUserIn: () {
                        // reset password
                        passwordReset();
                      },
                      text: 'Reset Password'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
