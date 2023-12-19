// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boba_tea_app/components/login_button.dart';
import 'package:boba_tea_app/components/login_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({required this.onTap, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  //sign user in and navigate to home page
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible:
          false, // Prevents the dialog from being dismissed by tapping outside
    );

    // try to create user account
    try {
      //check if passwords match
      if (passwordController.text == confirmPasswordController.text) {
        // create user account
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // add user details
        adduserDetails(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          int.parse(ageController.text),
        );

        // Dismiss the dialog when sign-up is successful
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        // Dismiss the dialog when passwords do not match
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // Dismiss the dialog when an error occurs
        Navigator.of(context).pop();
      }
      if (e is FirebaseAuthException) {
        String message;
        if (e.code == 'invalid-credential') {
          // Handle invalid credential error
          message =
              'The supplied auth credential is incorrect, malformed, or has expired.';
        } else {
          // Handle other errors
          message = 'An error occurred while signing up: ${e.message}';
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        // If the exception is not a FirebaseAuthException, rethrow it.
        rethrow;
      }
    }
  }

  void adduserDetails(
      String firstName, String lastName, String email, int age) async {
    // get current user
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
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
                height: 20,
              ),
              //logo
              const Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),

              const SizedBox(
                height: 20,
              ),

              //welcome back, you've been missed!
              const Text("Let's create an account for you!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 25,
              ),
              LoginFields(
                hintText: "First Name",
                obscureText: false,
                controller: firstNameController,
              ),
              LoginFields(
                hintText: "Last Name",
                obscureText: false,
                controller: lastNameController,
              ),
              LoginFields(
                hintText: "Age",
                obscureText: false,
                controller: ageController,
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

              // confirm password textfield
              LoginFields(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: true,
              ),

              const SizedBox(
                height: 20,
              ),
              // login button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoginButton(
                  text: "Sign Up",
                  signUserIn: () => signUserUp(),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                // not a member? sign up here
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
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
                    child: const Text("Login now",
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
