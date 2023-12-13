import 'package:boba_tea_app/components/login_button.dart';
import 'package:boba_tea_app/components/login_fields.dart';
import 'package:boba_tea_app/components/square_tile.dart';
import 'package:boba_tea_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in and navigate to home page
  void signUserIn(BuildContext context) {
    //get username and password
    String username = usernameController.text;
    String password = passwordController.text;

    //check if username and password are correct
    if (username == "admin" && password == "admin") {
      //navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      //show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect username or password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
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
                hintText: "Username",
                controller: usernameController,
                obscureText: false,
              ),

              // password textfield
              LoginFields(
                hintText: "Password",
                controller: passwordController,
                obscureText: true,
              ),

              // forgot password button
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Forgot Password?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),

              // login button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoginButton(
                  signUserIn: () => signUserIn(context),
                ),
              ),

              const SizedBox(
                height: 50,
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
                height: 50,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google logo
                  SquareTile(imagePath: 'lib/assets/images/google_logo.png'),

                  SizedBox(
                    width: 50,
                  ),

                  // apple logo
                  SquareTile(imagePath: 'lib/assets/images/apple_logo.png'),
                ],
              ),

              // not a member? sign up here
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Not a member? Sign up here",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
