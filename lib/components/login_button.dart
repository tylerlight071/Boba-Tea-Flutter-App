import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function signUserIn;
  const LoginButton({super.key, required this.signUserIn});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              signUserIn();
            },
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ));
  }
}
